#!/bin/sh -l

# Use INPUT_<INPUT_NAME> to get the value of an input
GREETING="Hello, $CONTAINER_NAMES!"

# Get the list of changed files using `github.event`
changed_files=$(jq -r '.commits[].added + .commits[].modified + .commits[].removed' "$GITHUB_EVENT_PATH")

# Print the list of changed files
echo "Changed files: $changed_files"

echo "greeting=$GREETING"

#!/bin/bash
# Get the files that were changed in the last commit and check if any of the
# string arguments to the script are substrings of these filenames.
CHANGED_FILES=$(git diff --name-only HEAD HEAD~1)
for str in "$@"; do
  for file in $CHANGED_FILES; do
    if echo "$file" | grep -q "$str"; then
      docker compose restart "$str"
      break
    fi
  done
done
exit 0



exit 0
