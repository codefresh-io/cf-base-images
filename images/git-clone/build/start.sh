set -e

[ -z "$SHA" ] && [ -z "$BRANCH" ] && (echo "missing SHA and BRANCH vars" | tee /dev/stderr) && exit 1

echo on
cd /

echo "$PRIVATE_KEY" > /root/.ssh/codefresh
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/*

#eval "ssh-agent -s"
#ssh-add $key
echo "cloning $repo"
git clone $repo /src
ls -la
cd /src

if [ "$BRANCH" ]; then
  git checkout $BRANCH
  if [ "$SHA" ]; then
    git reset $SHA --hard
  fi
else
  git checkout $SHA
fi

[ -z "$OWNER" ] || chown -R $OWNER .


