# Linux Cluster Monitoring Agent
This project is under development. Since this project follows the GitFlow, the final work will be merged to the main branch after Team Code Team.
EOF


## Introduction
(about 100-150 words)
LCA (Linux Cluster Administration) team has developed a Linux Cluster Monitoring application which can monitor useful  
information like hardware specifications and hardware usage data in real time. These include cpu, memory and disk usage related data.

We have chosen PostgresSQL Database for its robustness, scalability and security features that allow a great experience to work with.

PostgresSQL DB instance is running inside a Docker container. We are using docker image postgres:9.6-alpine for seamless experience with the database.

We have written a few Bash Scripts who are responsible for collecting the hardware specifications and real-time hardware data usage along with the timestamp  
and hostname which gets stored in the database because of automation.

Git Version Control has been a great choice for tracking the development process and for checkpointing purposes. It offers great features and user-friendly  
experience for software development projects.


## Quick Start

### Clone the repository
````
#Clone the repo
git clone https://github.com/Jarvis-Consulting-Group/jarvis_data_eng-d14mittal 

#Change directory to LCA project
cd jarvis_data_eng-d14mittal/linux_sql
````

### Create/Start/Stop Docker Container with Postgres:Alpine-9.6 Image

````
# To create a psql instance
bash ./scripts/psql_docker.sh create [db_username][db_password]

# To start a psql instance that is already created
bash ./scripts/psql_docker.sh start 

# To stop a running psql instance 
bash ./scripts/psql_docker.sh stop 
````

### Create Database host_agent in PostgresSQL DB
````
# Running the sql script creates database host_agent, host_info and host_usage tables in host_agent database 
psql -h localhost -U postgres -d host_agent -f ./sql/ddl.sql
````

### Insert hardware specs data into the DB using host_info.sh
```` 
# Insert hardware specifications into host_info table
bash ./script/host_info.sh host_agent_ip 5432 host_agent postgres password
````

### Insert hardware usage data into the DB using host_usage.sh
````
# Insert metric usage data into host_usage table using host_usage.sh
bash ./script/host_usage.sh host_agent_ip 5432 host_agent postgres password
````

### Crontab setup
````
crontab -e
#add this to crontab
* * * * * bash /home/centos/dev/jrvs/bootcamp/linux_sql/host_agent/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log
````

# Implemenation

Implementation of the LCA project has been incorporated in the Linux environment with CentOS 7 distribution. The objective of this project is to create a software product used for hardware-usage monitoring of Linux Clusters.   
Project started off with the Docker Installation and Postgres:Alpine-9.6 image used for creating a Docker container running the instance of PostgresSQL DB. We now proceed to install psql CLI tool used to connect and manipulate the DB with hardware statistics.

## Architecture
Draw a cluster diagram with three Linux hosts, a DB, and agents (use draw.io website). Image must be saved to the `assets` directory.

## Scripts
Shell script description and usage (use markdown code block for script usage)
- psql_docker.sh
- host_info.sh
- host_usage.sh
- crontab
- queries.sql (describe what business problem you are trying to resolve)

## Database Modeling
Describe the schema of each table using markdown table syntax (do not put any sql code)
- `host_info`
- `host_usage`

# Test
How did you test your bash scripts DDL? What was the result?

# Deployment
How did you deploy your app? (e.g. Github, crontab, docker)

# Improvements
Write at least three things you want to improve
e.g.
- handle hardware updates
- blah
- blah
