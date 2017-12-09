# obstacle_concourse
deploy app with concourse and test it with dgoss
 
## application
this app has following features:
* ruby-based rack app
* centos base image
* runs on AWS ECS
* served on port 8080

## functionality
this app is an HTTP server that sends plain-text responses as follows:
* GET /       => "hello world"
* GET /hello  => "hello"
* GET /world  => "world"

Note: 
Each endpoint should also accept these query parameters:
uppercase, which if true should return the string but capitalized, e.g. HELLO WORLD
reversed, which if true should return the reverse of the string, e.g. dlrow olleh

## deployment
* deployed via (concourse CI)[https://concourse.ci] (see concourse.yaml)
* deployed using Docker compose (see docker-compose.yaml) onto EC2 instance
* ...or using Docker compose onto ECS
* deployed to concourse lite VM with BOSH

## notes
* concourse reports build statuses back to this repo, and builds automatically when this a push to master occurs

## testing
this app has tests for container health and app functionality using dgoss.
