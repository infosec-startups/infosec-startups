#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Update theme before build
git submodule update --init --recursive

# Build the project.
hugo -t slate

cd public
rsync -a . ../../infosec-startups.github.io/ #Path to target repo
cd ../
rm -drf public #Remove build dir from current root

#Switch to target repo
cd ../infosec-startups.github.io

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Come Back up to the Project Root
cd ..
