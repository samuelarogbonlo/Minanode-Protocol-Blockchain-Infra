 #!/bin/bash
echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list
sudo apt-get update -y && sudo apt-get install -y docker
sudo systemctl start docker
sudo apt-get install -y curl unzip mina-mainnet=1.2.0-a42bdee
        
