FROM ubuntu:latest

WORKDIR /work

CMD ["bash"]

# Packer is a special build because Digitalocean support was broken in latest official 1.3.1
RUN apt update && apt install -y curl unzip \
	&& mkdir -p /tmp/install \
	&& cd /tmp/install \
	&& curl --fail --location -o packer.zip https://github.com/hashicorp/packer/files/2397072/packer.zip \
	&& unzip packer.zip && mv packer /usr/local/bin/packer \
	&& curl --fail --location -o terraform.zip https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip \
	&& unzip terraform.zip && mv terraform /usr/local/bin/terraform \
	&& rm -rf /tmp/install \
	&& cd /work \
	&& echo 'provider "digitalocean" {} provider "aws" {} provider "cloudflare" {} provider "hcloud" {}' > dummy.tf \
	&& terraform init \
	&& rm dummy.tf

# at the end we did something unorthodox - have a hack for Terraform to download Digitalocean
# plugin so we can bake that into the Docker image. we did it because I don't trust the dynamic
# load mechanism to deliver us a working plugin at the container start time..

COPY bin /work/bin
COPY droplet /work/droplet
COPY digitalocean-coreos.json /work/digitalocean-coreos.json
