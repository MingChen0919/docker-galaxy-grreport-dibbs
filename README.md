# Docker Galaxy GRReport DIBBs

This Docker container is built upon the `mingchen0919/docker-grreport`

# Regex Work

```
ls tool_yml_files > tool_installing_Dockerfile_commands.txt 
```

Open `tool_installing_Dockerfile_commands.txt ` and run the following Regex jobs.

Step 1:

* Pattern: `^`
* Replacement: `ADD tool_yml_files/`

Step 2:

* Pattern: `(\d\d_.+yml)`
* Replacement: `\1 \$GALAXY_ROOT/tool_yml_files/\1\rRUN install-tools $GALAXY_ROOT/tool_yml_files/\1\r`

This will generate Docker commands for installing each tools. Copy the content to the ***Dockerfile*** file.

# Build Docker image

```
docker build -t 'mingchen0919/docker-galaxy-grreport-dibbs' ./
```