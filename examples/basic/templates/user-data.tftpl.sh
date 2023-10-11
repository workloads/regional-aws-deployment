#!/bin/bash

# This file is an example of user-data payload that may be used to install
# HashiCorp Nomad and other relevant packages on an Ubuntu compute instance.
#
# This file is not intended to be "production-ready" and should only be used
# as a starting point for your own configuration and deployment strategies.
#
# See github.com/workloads/packer-templates for a more resilient approach.

# configuration
BASE_KEYRING="/etc/apt/keyrings"
BASE_PACKAGES_INSTALL="ca-certificates curl gpg"
BASE_SOURCELIST="/etc/apt/sources.list.d"

# see https://docs.docker.com/engine/install/ubuntu/ for more information
DOCKER_KEY="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_KEYRING="$${BASE_KEYRING}/docker.gpg"
DOCKER_PACKAGES_REMOVE="docker.io docker-doc docker-compose podman-docker containerd runc"
DOCKER_PACKAGES_INSTALL="docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
DOCKER_REPOSITORY="https://download.docker.com/linux/ubuntu"
DOCKER_SOURCELIST="$${BASE_SOURCELIST}/docker.list"

# see https://www.hashicorp.com/official-packaging-guide for more information
HASHICORP_KEY="https://apt.releases.hashicorp.com/gpg"
HASHICORP_KEYRING="$${BASE_KEYRING}/hashicorp-archive-keyring.gpg"
HASHICORP_PACKAGES_INSTALL="nomad"
HASHICORP_REPOSITORY="https://apt.releases.hashicorp.com"
HASHICORP_SOURCELIST="$${BASE_SOURCELIST}/hashicorp.list"

# see https://developer.hashicorp.com/nomad/docs/install/production#configuring-nomad for more information
NOMAD_BASE_DIR="/opt/nomad"
NOMAD_CONFIG_DIR="/etc/nomad.d"
NOMAD_CONFIG_DATA="${NOMAD_CONFIG_DATA}"

################################################################################
# system operations                                                            #
################################################################################

# get hostname from IMDS and then set hostname
# see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
 IMDS_SERVER="http://169.254.169.254/latest"
 IMDS_TOKEN=$(curl --header "X-aws-ec2-metadata-token-ttl-seconds: 21600" --silent --request PUT "$${IMDS_SERVER}/api/token")
 IMDS_TAG_HOSTNAME=$(curl --header "X-aws-ec2-metadata-token: $${IMDS_TOKEN}" --silent  --request GET "$${IMDS_SERVER}/meta-data/tags/instance/Name")
 IMDS_TAG_INSTANCEID=$(curl --header "X-aws-ec2-metadata-token: $${IMDS_TOKEN}" --silent  --request GET "$${IMDS_SERVER}/meta-data/instance-id")

# see https://man7.org/linux/man-pages/man1/hostnamectl.1.html
sudo hostnamectl hostname "$${IMDS_TAG_HOSTNAME}-$${IMDS_TAG_INSTANCEID}"

# update packages
sudo apt update

# upgrade packages (may require reboot!)
# sudo apt upgrade

# install GPG to allow for package verification
# shellcheck disable=SC2086
sudo apt install --yes $${BASE_PACKAGES_INSTALL}

################################################################################
# Docker-specific steps                                                        #
################################################################################

# remove existing and potentially conflicting Docker packages
# shellcheck disable=SC2086
sudo apt remove --yes $${DOCKER_PACKAGES_REMOVE}

# download Docker Key and add to GPG Keyring
wget \
  --output-document=- \
  "$${DOCKER_KEY}" \
| \
sudo gpg \
  --dearmor \
  --output "$${DOCKER_KEYRING}"

# add Docker repository information to APT sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=$${DOCKER_KEYRING}] $${DOCKER_REPOSITORY} $(lsb_release -cs) stable" \
| \
sudo tee "$${DOCKER_SOURCELIST}" > /dev/null

# update packages
sudo apt update

# install packages
# shellcheck disable=SC2086
sudo apt install --yes $${DOCKER_PACKAGES_INSTALL}

################################################################################
# HashiCorp-specific steps                                                     #
################################################################################

# download HashiCorp Key and add to GPG Keyring
wget \
  --output-document=- \
  "$${HASHICORP_KEY}" \
| \
sudo gpg \
  --dearmor \
  --output "$${HASHICORP_KEYRING}"

# add HashiCorp repository information to APT sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=$${HASHICORP_KEYRING}] $${HASHICORP_REPOSITORY} $(lsb_release -cs) main" \
| \
sudo tee "$${HASHICORP_SOURCELIST}" > /dev/null

# update packages
sudo apt update

# install packages
sudo apt install --yes $${HASHICORP_PACKAGES_INSTALL}

# write Nomad config
mkdir -p "$${NOMAD_BASE_DIR}"



# start Nomad
sudo service nomad start
