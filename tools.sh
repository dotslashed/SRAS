#!/bin/bash

echo "[+]Installing Tools..."

go install github.com/tomnomnom/hacks/get-title@latest > /dev/null 2>&1

apt install -y libpcap-dev > /dev/null 2>&1

wget "https://github.com/projectdiscovery/naabu/releases/download/v2.0.5/naabu_2.0.5_linux_amd64.zip" > /dev/null 2>&1

unzip naabu_2.0.5_linux_amd64.zip > /dev/null 2>&1

mv naabu /usr/local/bin

rm naabu_2.0.5_linux_amd64.zip

go install github.com/tomnomnom/hacks/unfurl@latest > /dev/null 2>&1

go install github.com/nytr0gen/deduplicate@latest > /dev/null 2>&1

git clone https://github.com/Qianlitp/crawlergo.git > /dev/null 2>&1

cd crawlergo; cd cmd; cd crawlergo

go build crawlergo_cmd.go > /dev/null 2>&1

mv crawlergo_cmd /usr/local/bin

cd ../../../

rm -rf crawlergo/

go install github.com/003random/getJS@latest > /dev/null 2>&1

go install github.com/hakluke/hakrawler@latest > /dev/null 2>&1

go install github.com/Emoe/kxss@latest > /dev/null 2>&1

go install github.com/haccer/subjack@latest > /dev/null 2>&1

go install github.com/edoardottt/lit-bb-hack-tools/eae@latest > /dev/null 2>&1

echo "Installation Completed!"
