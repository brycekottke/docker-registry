####1. Fill out the deploy-registry.sh script with necessary s3 bucket info.
  $ vi deploy-registry.sh
  
  $ ./deploy-registry.sh
  -----
####2. Generate your Signed server and client certificate / keys

When generating the keys and certs the only necessary thing to enter is the password
(which we will remove with the generate-ca.sh script) and the DNS name of your private
registry you will be setting up.

**Example: Common Name (e.g. server FQDN or YOUR name): registry.mydomain.com**

  $ mkdir -p /app/certs
  
  $ mv generate-ca.sh /app/certs
  
  $ cd /app/certs
  
  $ ./generate-ca.sh
  -----
####3. Build your nginx-registry container and run nginx-registry container

Navigate back to wherever you cloned this repository.

  $ docker build -t nginx-registry .
  
  $ docker run --name nginx-registry -d --link registry:registry -v /app/certs:/etc/nginx/certs -p 443:443 nginx-registry
  -----
####4. Setup / Configure your docker client (your computer)

On the client host (your computer), copy the following files over from your docker registry
server and place them in the directory listed below. client.key, client.crt, ca.crt.

/etc/docker/certs.d/registry.yourcompany.com

Example: /etc/docker/certs.d/dockerhub.redapt.com/
  -----
#####IMPORTANT!
You have to rename the 'client.crt' file to 'client.cert' in order for the docker CLI tools
to authenticate to your new docker registry server.

You can verify SSL is working with the following curl command
  $ curl -v -s -k --key client.key --cert client.crt https://dockerhub.redapt.com

Tag your docker image appropriately and push to our private docker registry
  $ docker tag ubuntu dockerhub.redapt.com/ubuntu

Boom! All done!
