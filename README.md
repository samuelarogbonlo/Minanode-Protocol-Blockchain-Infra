<img width="799" alt="Screenshot 2021-07-23 at 17 31 01" src="https://user-images.githubusercontent.com/47984109/126813260-7bb1465a-8efc-478d-846f-3839b8dc1d15.png">

# O(1) Labs Task

# MinaNode Infrastructure On Amazon Web Services
Opinionated project architecture for Mina node following the required documentation from the Mina Protocol website.

## Core Structure
    Mina Node Deployment
      │   ├── app.py
      │   │   > Python
      │   │
      │   ├── metric_scraper
      │   │   > Metric Requast
      │   │   > Caching
      │   │
      │   └── wsgi.py
      │
      ├── Terraform
      │   > Modules
      │   > Main.tf 
      │   > Variables.tf
      │   > minanode-script.sh    
      │
      └── README.md (you are here)

# Task 1
The setup for the mina node was done on AWS (could be any other provider). 

## Integral Parts Of AWS Infrastructure
- **EC2 Instance**: An EC2 instance was used to run the base server and the size was c5.2xlarge which directly implies the intensity of the node itself. It requires lots of RAM and CPU power to run succesfully or else the Mina Daemon will be crashing upon startup. A typical EC2 Instance of this size has the following specifications:
    - Memory: 16.0 GiB	
    - vCPUs: 8 vCPUs
    - Instance Storage: EBS only	
    - Network Performance: Up to 10 Gigabit	
- **Internet Gateway**: The internet gateway just allows communication between the Virtual private Cloud and the internet.
- **CIDR**: Here, it was used to identify the subnets to be used in the architecture itself. 
- **Region**: The region was selected as us-east-1 because it is the default and seems to be a bit affordable from my experiences.
- **Availablity Zone**: The default AZ was used. 
- **Routing Table**: This tables tells the router that a certain destination can be reached and the internet gatway was involved here as well.
- **Terraform**: The IAC tool - terraform was used to orchestrate the infrastructure on AWS; nothing was done manually and one of the reasons I chose it was the ability to modularize the files so as to make them easy to read and repeatable incase there needs to be a change.
- **Security groups**: The security group was used to define the inbound/outboudn rules so as to proeply control traffic on the VPC and of course expose ports for ssh and other stuff.
- **Key Pairs**: This was created to validate access into the server.

## Mina Output 
The image below shows the response of running ```mina client status```:
<img width="923" alt="Screenshot 2021-07-22 at 18 07 31" src="https://user-images.githubusercontent.com/47984109/126812390-18907328-8e00-4d3f-bb08-cef55e311ed4.png">


## Configuration Files 
The configuration files used for this project is embedded in this repo itself. from here, you can view the terraform script used to orchestrare the architecture.

The other commands used include:
- ```terraform init```
- ```terraform plan -var-file=terraform.tfvars -out=tfplan```
- ```terraform apply --auto-approve```

## Setup and Running
The documentation (here)[https://docs.minaprotocol.com/en/getting-started] does justice to how the keypair was generated and the setup was made for connecting network to attempt the first payment and run the mina daemon.

    
# Task 2

## Steps

- Deployed the mina daemon with the flag --metrics-port 6060.
- Installed the node-exporter following this [documentation](https://prometheus.io/docs/guides/node-exporter/), I also had to create a user and give permissions from the node-exporter service file as this was not indicated in the documentation.
- The node-exporter service is exposed on port 9100 by default. 
- Then ran the command ```curl http://localhost:9100/metrics``` and the metrics to be scraped from the mina node in the server.
- Created a python script to get the logs from that url and you can find the details in this repository. The web scraper is designed to check the response status of the node then store it in a variable on the running server with a cronjob to do this every minute. So paradventure the node goes down, we can still access the cached information and know what went wrong for documentation, corrections, post-mortem analysis amongst many other reasons. 

In summary, it has a scheduler and cronjob attached to it with of course a caching mechanism. The metrics can be viewed directly http://18.206.191.172:9100/metrics or securely here https://metric-mon.herokuapp.com/.

## Outputs
The scripts in the ```metric.scraper.py``` file required for the task is already in this repository. Then the output of the script is pretty lengthy but could be accessed via the URL indicated in the previous section.

## Authors
- Samuel Arogbonlo - [GitHub](https://github.com/samuelarogbonlo) · [Twitter](https://twitter.com/samuelarogbonlo)

## Collaborators
- [YOUR NAME HERE] - Feel free to contribute to the codebase by resolving any open issues, refactoring, adding new features, writing test cases or any other way to make the project better and helpful to the community. Feel free to fork and send pull requests.

## Resources and Inspirations
- Start learning by looking at sample codes on GitHub: [#LearnByExamples](https://github.com/topics/learn-by-examples)

## Hire me
Looking for an Infrastructure engineer to build your next infrastruture in O(1) Labs and work remotely? Get in touch: [sbayo971@gmail.com](mailto:sbayo971@gmail.com)


## License

The MIT License (http://www.opensource.org/licenses/mit-license.php)

