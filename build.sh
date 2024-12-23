docker rmi -f $(docker images -q ansible-test) 2>/dev/null || true
docker build -t ansible-test .
