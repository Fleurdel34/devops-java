## Documentation workflow

## ci.yml file common to both angular and java projects

# Job test automatically detects the project type with an condition:

=> Angular if a package.json file exists
=> Java if a build.gradle file exists

Angular Job test:
Installation of Node and npm, then:
npm ci
npm run build 
npm test (coverage report generate)

Java Job test:
Installation JDK and Gradle, then:
./gradlew build
./gradlew test
Packaging with bootWar

# Job Build common to both project :

The build job is identical for both projects:no project‑type detection is needed because the Docker configuration is the same.
(Each project has its own Dockerfile):
Docker image is built using the project’s Dockerfile
Tag format: branch-sha
Image is published to the GitHub Container Registry (GHCR)

# Job release for project java :

Setup Node
Install Semantic Release and plugin
Run npx semantic-release
Build and push image Docker with tag (version + branch + sha)