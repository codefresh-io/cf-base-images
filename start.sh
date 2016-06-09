set -e

[ -z "$REVISION" ] && (echo "missing REVISION var" | tee /dev/stderr) && exit 1

echo "$PRIVATE_KEY" > /root/.ssh/codefresh
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/*

echo "cloning $REPO"
cd $WORKING_DIRECTORY
git clone $REPO $CLONE_DIR
cd $CLONE_DIR

if [ -n "$REVISION" ]
then
  git checkout $REVISION
fi