#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install -y unzip

echo "Fetching Nomad..."
cd /tmp
curl -sLo nomad.zip http://releases.hashicorp.com/nomad/${nomad_version}/nomad_${nomad_version}_linux_amd64.zip

echo "Installing Nomad..."
unzip nomad.zip >/dev/null
sudo chmod +x nomad
sudo mv nomad /usr/local/bin/nomad

sudo echo "export NOMAD_ADDR=\"http://${nomad_alb}:4646\"" >> /home/ubuntu/.profile

echo "Fetch Jobs"
curl -sLo /home/ubuntu/http_test.hcl https://raw.githubusercontent.com/hashicorp/nomad-auto-join/master/jobs/http_test.hcl
curl -sLo /home/ubuntu/syslog.hcl https://raw.githubusercontent.com/hashicorp/nomad-auto-join/master/jobs/syslog.hcl
