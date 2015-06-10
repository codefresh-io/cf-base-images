set -e

echo on
cd /

echo "$PRIVATE_KEY" > /root/.ssh/codefresh
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/*

#eval "ssh-agent -s"
#ssh-add $key
echo "cloning  $repo"
git clone $repo /src
ls -la
cd /src
git reset --hard $SHA1
