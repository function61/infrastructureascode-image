FROM ubuntu:latest

WORKDIR /work

CMD ["bash"]

RUN apt update && apt install -y curl unzip \
	&& mkdir -p /tmp/install \
	&& cd /tmp/install \
	&& curl --fail --location -o packer.zip https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip \
	&& unzip packer.zip && mv packer /usr/local/bin/packer \
	&& curl --fail --location -o terraform.zip https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip \
	&& unzip terraform.zip && mv terraform /usr/local/bin/terraform \
	&& rm -rf /tmp/install \
	&& cd /work \
	&& echo 'provider "digitalocean" { version = "~> 1.1.0" } provider "aws" { version = "~> 1.54.0" } provider "cloudflare" { version = "~> 1.10.0" } provider "hcloud" { version = "~> 1.7.0" }' > dummy.tf \
	&& terraform init \
	&& rm dummy.tf

# at the end we did something unorthodox - have a hack for Terraform to download Digitalocean
# plugin so we can bake that into the Docker image. we did it because I don't trust the dynamic
# load mechanism to deliver us a working plugin at the container start time..

COPY bin /work/bin
COPY modules /work/modules
COPY packerfiles /work/packerfiles
COPY bin/deploy-lambdafunc.sh /usr/local/bin/deploy-lambdafunc.sh
