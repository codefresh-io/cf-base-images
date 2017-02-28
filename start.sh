set -e

[ -z "$REVISION" ] && (echo "missing REVISION var" | tee /dev/stderr) && exit 1

echo "$PRIVATE_KEY" > /root/.ssh/codefresh
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/*

cd $WORKING_DIRECTORY

# Check if the cloned dir already exists from previous builds
if [ -d "$CLONE_DIR" ]; then

  # Cloned dir already exists from previous builds so just fetch all the changes
  echo "Preparing to update $REPO"
  cd $CLONE_DIR

  # Reset the remote URL because the embedded user token may have changed
  git remote set-url origin $REPO

  echo "Cleaning up the working directory"
  git reset -q --hard
  git clean -df
  git gc
  git remote prune origin

  echo "Fetching the updates from origin"
  git fetch

  if [ -n "$REVISION" ]; then

      echo "Updating $REPO to revision $REVISION"
      git checkout $REVISION

      CURRENT_BRANCH="git branch 2>/dev/null | grep '^*'"

      echo "Is revision '$REVISION' equal to the current branch '$CURRENT_BRANCH'?"
      # If the revision is identical to the current branch we can rebase it with the latest changes. This isn't needed when running detached
      if [ "$REVISION" == "$CURRENT_BRANCH" ]; then
	 echo 'Yes, rebasing.'
         git rebase
      fi
  fi
else

  # Clone a fresh copy
  echo "cloning $REPO"
  git clone $REPO $CLONE_DIR
  cd $CLONE_DIR

  if [ -n "$REVISION" ]; then
    git checkout $REVISION
  fi
fi
