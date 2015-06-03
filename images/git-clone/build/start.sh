echo on
cd /
#eval "ssh-agent -s"
#ssh-add $key
echo "status is.. $status"
echo "cloning ... $repo"
git clone $repo /src
ls -la
cd /src
git reset --hard $SHA1
