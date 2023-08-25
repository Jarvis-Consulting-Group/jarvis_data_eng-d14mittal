# Introduction
The Grep app project has been designed to match the Regular Expression pattern from a file and write all the matches to an output file. The project has been implemented using Core Java and Slf4h-log4j dependency for logging purposes. All the dependencies and project build management is handled by Maven build tool.
The Grep application can be dockerized with Dockerfile and could easily run on any platform for distribution and deployment.

# Quick Start

1. Build Application
```
cd core_java/grep
mvn clean package
```

2. Run Java App in Local Environment
```
java -cp target/grep-1.0-SNAPSHOT.jar ca.jrvs.apps.grep.JavaGrepImp '.*pattern.*' <path_to_root_dir> /<path_to_output_file.txt>
```

[//]: # (3. Run Java App in Docker Container)

[//]: # (```)

[//]: # ()
[//]: # (cd core_java/grep)

[//]: # ()
[//]: # (#Package your java app)

[//]: # (mvn clean package)

[//]: # ()
[//]: # (#Build Docker Image)

[//]: # (docker build -f Dockerfile -t grep .)

[//]: # ()
[//]: # (#Run the image in the docker container)

[//]: # (docker run --rm -v `pwd`/data:/data -v `pwd`/log:/log grep .*Romeo.*Juliet.* /data /log/grep.out)

[//]: # (```)

# Implemenation
Process method pseudocode processing the all the files and matching the patterns, then writing to the output file.
### Pseudocode
```
fucntion process(){
    matchedLines = List<String>()
    for (file in getRootPath){
        for(string in file){
            if(containsPattern(string))
                matchedLines.add(string)
        }
    }
    
    writeToFile(matchedLines)
    
```

## Performance Issue
The application can cause performance issue because of the large data files to process which can lead to OutOfMemoryError.
The application will load all the resource files in the memory before processing, and if the input file is large it can definitely lead to out of memory errors.

# Test
- Implementing the loggers and printing messages to check the status of application.
- Testing multiple use cases and different regex manually and verifying the output in the output file.

# Deployment
Dockerized the grep application for deployment and distribution.
```
cd core_java/grep

#Register Docker hub account
docker_user=your_docker_id
docker login -u ${docker_user} --password-stdin 

#Create dockerfile (make sure you understand all commands)
cat > Dockerfile << EOF
FROM openjdk:8-alpine
COPY target/grep*.jar /usr/local/app/grep/lib/grep.jar
ENTRYPOINT ["java","-jar","/usr/local/app/grep/lib/grep.jar"]
EOF

#Package your java app
mvn clean package

#build a new docker image locally
docker build -t ${docker_user}/grep .

#verify your image
docker image ls | grep "grep"

#run docker container (you must undertand all options)
docker run --rm \
-v `pwd`/data:/data -v `pwd`/log:/log \
${docker_user}/grep .*Romeo.*Juliet.* /data /log/grep.out

#push your image to Docker Hubg
docker push ${docker_user}/grep

#Go to hub.docker.com and verify your image
```

# Improvement
- Performance can be optimized if memory management is handled using Stream API.
- More emphasis on testing the business logic with JUnit framework.
- Performance testing with Microprofile dependency to check the time taken to execute particular methods.