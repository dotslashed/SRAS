#!/bin/bash

echo "[+]Installing Tools..."

go install github.com/tomnomnom/hacks/get-title@latest > /dev/null 2>&1

apt install -y libpcap-dev > /dev/null 2>&1

go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest > /dev/null 2>&1

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

go install -v github.com/musana/mx-takeover@latest > /dev/null 2>&1

echo "Installation Completed!"
