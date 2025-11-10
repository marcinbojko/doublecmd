#!/usr/bin/env bash
set -euo pipefail # Exit on error, undefined vars, pipe failures

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Helper function for error messages
error_exit() {
	echo -e "${RED}ERROR: $1${NC}" >&2
	exit 1
}

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/replace.config"
[[ -f "$CONFIG_FILE" ]] || error_exit "Configuration file not found: $CONFIG_FILE"

# shellcheck source=.snippets/replace.config
source "$CONFIG_FILE"

# Validate required configuration
for var in NUSPEC_FILE GITHUB_ORG URL64 EXPECTED_EMAIL_HASH; do
	[[ -n "${!var}" ]] || error_exit "Missing required configuration: $var"
done

# Detect OS-specific tools
case "$(uname -s)" in
Linux*)
	grep_command="grep"
	sed_binary="sed"
	;;
Darwin*)
	grep_command="ggrep"
	sed_binary="gsed"
	;;
*)
	error_exit "Unsupported operating system: $(uname -s)"
	;;
esac

# Validate required files exist
[[ -f "$NUSPEC_FILE" ]] || error_exit "File $NUSPEC_FILE does not exist"
[[ -f "../tools/chocolateyinstall.ps1" ]] || error_exit "File ../tools/chocolateyinstall.ps1 does not exist"

# Git operations - always switch to test branch
echo -e "${GREEN}Switching to test branch...${NC}"
git checkout test || error_exit "Failed to checkout test branch"

echo -e "${GREEN}Pulling latest changes...${NC}"
git pull || error_exit "Failed to pull latest changes"

echo -e "${GREEN}Extracting version and id from $NUSPEC_FILE...${NC}"
version=$($grep_command -oPm1 "(?<=<version>)[^<]+" "$NUSPEC_FILE")
id=$($grep_command -oPm1 "(?<=<id>)[^<]+" "$NUSPEC_FILE")
[[ -n "$version" ]] || error_exit "Failed to extract version from $NUSPEC_FILE"
[[ -n "$id" ]] || error_exit "Failed to extract id from $NUSPEC_FILE"

# Expand URL templates with actual values
url64=$(eval echo "$URL64")
url=$(eval echo "$URL")

# Helper function to verify checksum
verify_checksum() {
	local file_url=$1
	local expected=$2
	local label=$3

	echo -e "${GREEN}Verifying $label checksum...${NC}"
	local actual
	actual=$(curl -sL "$file_url" | sha256sum | cut -d' ' -f1) || error_exit "Failed to download $label file"

	if [[ "$actual" == "$expected" ]]; then
		echo "✓ $label checksums match"
	else
		error_exit "$label checksums do not match!\nExpected: $expected\nGot:      $actual"
	fi
}

# Get checksums
if [[ -n "$CHECKSUMS_URL" ]]; then
	checksums_url=$(eval echo "$CHECKSUMS_URL")
	echo -e "${GREEN}Downloading checksums from checksums file...${NC}"
	checksum64=$(curl -sL "$checksums_url" | grep "$CHECKSUM_GREP_PATTERN" | awk '{print $1}')
	[[ -n "$checksum64" ]] || error_exit "Failed to extract checksum from checksums file"

	[[ -n "$url" ]] && checksum=$(curl -sL "$url" | sha256sum | cut -d' ' -f1)
else
	echo -e "${GREEN}Calculating checksums directly from downloads...${NC}"
	checksum64=$(curl -sL "$url64" | sha256sum | cut -d' ' -f1) || error_exit "Failed to download 64-bit file"
	[[ -n "$url" ]] && checksum=$(curl -sL "$url" | sha256sum | cut -d' ' -f1)
fi

# Display information
printf "%-30s %s\n" "Version:" "$version"
printf "%-30s %s\n" "ID:" "$id"
printf "%-30s %s\n" "URL64:" "$url64"
printf "%-30s %s\n" "Checksum64:" "$checksum64"
[[ -n "$url" ]] && printf "%-30s %s\n" "URL:" "$url" && printf "%-30s %s\n" "Checksum:" "$checksum"

# Verify checksums by re-downloading
verify_checksum "$url64" "$checksum64" "64-bit"
[[ -n "$url" ]] && [[ -n "$checksum" ]] && verify_checksum "$url" "$checksum" "32-bit"

# Update PowerShell script
POWERSHELL_FILE="../tools/chocolateyinstall.ps1"
echo -e "${GREEN}Updating $POWERSHELL_FILE...${NC}"
"$sed_binary" -i "s|^\$version.*|\$version            = '$version'|g" "$POWERSHELL_FILE"
"$sed_binary" -i "s|^\$checksum64.*|\$checksum64         = '$checksum64'|g" "$POWERSHELL_FILE"
[[ -n "$url" ]] && "$sed_binary" -i "s|^\$checksum .*|\$checksum           = '$checksum '|g" "$POWERSHELL_FILE"
echo "✓ Updated $POWERSHELL_FILE"

# Check if tag already exists
if git rev-parse --quiet --verify "$version" >/dev/null 2>&1; then
	echo "Tag already exists: $version"
	exit 0
fi

# Validate git author before committing (prevent GitKraken profile issues)
echo -e "${GREEN}Validating git configuration...${NC}"
CURRENT_EMAIL=$(git config user.email)
CURRENT_NAME=$(git config user.name)
[[ -n "$CURRENT_EMAIL" && -n "$CURRENT_NAME" ]] || error_exit "Git author not configured! Please set user.name and user.email"

# Hash-based validation using configured expected hash
CURRENT_HASH=$(echo -n "$CURRENT_EMAIL" | sha256sum | cut -d' ' -f1)
if [[ "$CURRENT_HASH" != "$EXPECTED_EMAIL_HASH" ]]; then
	error_exit "Incorrect git author configuration!\nCurrent author: $CURRENT_NAME <$CURRENT_EMAIL>\nThis may be caused by GitKraken profile switching."
fi

echo -e "${GREEN}✓ Git author validated: $CURRENT_NAME <$CURRENT_EMAIL>${NC}"

# Create the commit and tag
echo -e "${GREEN}Creating commit and tag...${NC}"
git add -A || error_exit "Failed to add changes"
git commit -m "Version ${version}" || error_exit "Failed to create commit"
git tag "$version" || error_exit "Failed to create tag"

echo -e "${GREEN}✓ Successfully created commit and tag: $version${NC}"
echo "To push: git push origin $version"
