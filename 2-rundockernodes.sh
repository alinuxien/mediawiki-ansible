docker run -d --restart always --ip 172.17.0.2 --hostname http1 -p 32768:22 -p 8000:80 --name http1 --add-host bdd1:172.17.0.3 nodes
docker run -d --restart always --ip 172.17.0.3 --hostname bdd1 -p 32769:22 -p 3306:3306 --name bdd1 --add-host http1:172.17.0.2 nodes
