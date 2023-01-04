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

naabu -l naked_hosts.txt -p 100,1000,10000,10001,1010,1012,10134,102,1022,1023,1024,10243,1025,10250,1026,1027,1028,1029,104,10443,1050,10554,106,1063,1080,1099,11,110,111,1110,1111,11112,1119,11211,113,11300,1167,1177,119,1194,1200,12000,121,123,1234,12345,12443,1250,129,1290,13,131,1311,1344,135,1355,13579,1366,137,1388,139,1400,14147,14265,143,1433,1434,14344,1471,1494,15,1500,1515,1521,154,1554,1588,1599,16010,1604,16080,161,16464,1650,1660,16992,16993,17,17000,1723,1741,175,1777,179,180,1800,18081,18091,18092,1820,18245,1830,1833,1883,19,1900,1901,1911,1935,1947,195,1950,1951,1962,1981,199,1990,1991,20,2000,20000,2001,2002,2003,2006,2008,20087,2010,2012,2018,2020,2021,2022,20256,2030,2048,2049,2050,2051,2052,2053,2054,20547,2055,2056,2057,2058,2059,2060,2061,2062,2063,2064,2065,2066,2067,2068,2069,2070,20720,2077,2079,2080,2081,2082,2083,2086,2087,2095,2096,21,2100,21025,211,2111,2121,2122,2123,2126,21379,2150,2152,2181,22,2200,2201,2202,221,2211,222,2220,2221,2222,22222,2223,2225,2232,2233,225,2250,2259,2266,23,23023,2320,2323,2332,23424,2345,2351,2352,2375,2376,2379,2382,24,2404,2443,2455,2480,25,2506,25105,2525,2548,2549,2550,2551,2552,2553,2554,2555,2556,25565,2557,2558,2559,2560,2561,2562,2563,2566,2567,2568,2569,2570,2572,2598,26,2601,2602,2626,2628,263,264,2650,2701,27015,27016,27017,27036,2709,2761,2762,28015,28017,2806,2985,300,3000,3001,3002,3005,3048,3049,3050,3051,3052,3053,3054,3055,3056,3057,3058,3059,3060,3061,3062,3063,3066,3067,3068,3069,3070,3071,30718,3072,3073,3074,3075,3076,3077,3078,3079,3080,3081,3082,3083,3084,3085,3086,3087,3088,3089,3090,3091,3092,3093,3094,3095,3096,3097,3098,3099,3100,3101,3102,3103,3104,3105,3106,3107,3108,3109,311,3110,3111,3112,3113,3114,3115,3116,3117,3118,3119,3120,3121,3128,3129,3200,3211,3221,32400,3260,3270,32764,3283,3299,3306,33060,3307,3310,3311,3333,33338,3337,3352,3386,3388,3389,3391,340,3400,3401,3402,3403,3404,3405,3406,3407,3408,3409,3410,3412,3443,3460,3479,3498,3503,3521,3522,3523,3524,3541,3542,3548,3549,3550,3551,3552,3554,3555,3556,3557,3558,3559,3560,3561,3562,3563,3566,3567,3568,3569,3570,3671,3689,3690,37,3702,37215,3749,37777,3780,3784,3790,3791,3792,3793,3794,38,3838,389,3910,3922,3950,3951,3952,3953,3954,4000,4001,4002,4010,4022,4040,4042,4043,4063,4064,4070,4100,4117,4118,4157,41794,4190,4200,4242,4243,4282,43,4321,4369,443,4430,4433,444,4443,4444,4445,445,447,448,44818,4482,449,450,4500,4505,4506,4523,4524,4545,4550,4567,4643,4646,465,4664,4700,4711,4712,4730,4734,4747,47808,4782,4786,4800,4808,4840,4848,48899,49,491,4911,49152,49153,4949,4993,4999,500,5000,50000,5001,5002,5003,5004,5005,50050,5006,5007,50070,5008,5009,5010,50100,502,5025,503,5050,5060,5070,5080,5090,5094,51,5104,5108,51106,5122,51235,515,5150,5172,5190,520,5201,5209,522,5222,523,5269,5280,52869,53,5321,53413,5353,5357,5400,541,54138,5431,5432,5443,5446,5454,548,5494,54984,5500,554,5542,55442,55443,555,5552,5555,55553,55554,5560,5567,5568,5569,5577,5590,5591,5592,5593,5594,5595,5596,5597,5598,5599,5600,5601,5602,5603,5604,5605,5606,5607,5608,5609,5632,5672,5673,5683,5684,5800,5801,5822,5853,5858,587,5900,5901,5906,5907,5908,5909,591,5910,593,5938,5984,5985,5986,6000,60001,6001,6002,6003,6004,6005,6006,6007,6008,6009,6010,60129,6036,6080,6102,6161,62078,623,626,6262,6264,6308,631,6352,636,6363,6379,6443,646,6464,64738,6503,6510,6511,6512,6543,6550,6560,6561,6565,6580,6581,6588,6590,6600,6601,6602,6603,6605,6622,6650,666,6662,6664,6666,6667,6668,6697,6748,675,6789,685,6881,6887,69,6955,6969,6998,7,70,7000,7001,7002,7003,7004,7005,7010,7014,7070,7071,7080,7081,7090,7170,7171,7218,7396,7401,7415,7433,7443,7444,7445,7465,7474,7493,7500,7510,7535,7537,7547,7548,7634,7654,7657,7676,7700,771,772,777,7776,7777,7778,7779,7788,7887,789,79,7979,7998,7999,80,800,8000,8001,8002,8003,8004,8005,8006,8007,8008,8009,801,8010,8011,8012,8013,8014,8015,8016,8017,8018,8019,8020,8021,8022,8023,8024,8025,8026,8027,8028,8029,8030,8031,8032,8033,8034,8035,8036,8037,8038,8039,8040,8041,8042,8043,8044,8045,8046,8047,8048,8049,805,8050,8051,8052,8053,8054,8055,8056,8057,8058,806,8060,8064,8066,8069,8071,8072,808,8080,8081,8082,8083,8084,8085,8086,8087,8088,8089,8090,8091,8092,8093,8094,8095,8096,8097,8098,8099,81,8100,8101,8102,8103,8104,8105,8106,8107,8108,8109,8110,8111,8112,8118,8123,8126,8139,8140,8143,8159,8172,8180,8181,8182,8184,8190,82,8200,8222,8236,8237,8238,8239,8241,8243,8248,8249,8251,8252,8280,8281,8282,8291,83,830,832,8333,8334,8383,84,8401,8402,8403,8404,8405,8406,8407,8408,8409,8410,8411,8412,8413,8414,8415,8416,8417,8418,8419,8420,8421,8422,8423,8424,8425,8426,8427,8428,8429,843,8430,8431,8432,8433,8442,8443,8444,8445,8446,8447,8448,85,8500,8513,8545,8553,8554,8585,8586,8590,86,8602,8621,8622,8623,8637,8649,8663,8666,8686,8688,87,8700,873,8733,8765,8766,8767,8779,8782,8784,8787,8788,8789,8790,8791,88,880,8800,8801,8802,8803,8804,8805,8806,8807,8808,8809,8810,8811,8812,8813,8814,8815,8816,8817,8818,8819,8820,8821,8822,8823,8824,8825,8826,8827,8828,8829,8830,8831,8832,8833,8834,8835,8836,8837,8838,8839,8840,8841,8842,8843,8844,8845,8846,8847,8848,8849,8850,8851,8852,8853,8854,8855,8856,8857,8858,8859,8860,8861,8862,8863,8864,8865,8866,8867,8868,8869,8870,8871,8872,8873,8874,8875,8876,8877,8878,8879,888,8880,8881,8885,8887,8888,8889,8890,8891,8899,89,8935,8969,8983,8988,8989,8990,8991,8993,8999,90,9000,9001,9002,9003,9004,9005,9006,9007,9008,9009,9010,9011,9012,9013,9014,9015,9016,9017,9018,9019,902,9020,9021,9022,9023,9024,9025,9026,9027,9028,9029,9030,9031,9032,9033,9034,9035,9036,9037,9038,9039,9040,9041,9042,9043,9044,9045,9046,9047,9048,9049,9050,9051,9060,9070,9080,9082,9084,9088,9089,9090,9091,9092,9093,9094,9095,9096,9097,9098,9099,91,9100,9101,9102,9103,9104,9105,9106,9107,9108,9109,9110,9111,9119,9136,9151,9160,9189,9191,9199,92,9200,9201,9202,9203,9204,9205,9206,9207,9208,9209,9210,9211,9212,9213,9214,9215,9216,9217,9218,9219,9220,9221,9222,9251,9295,9299,9300,9301,9302,9303,9304,9305,9306,9307,9308,9309,9310,9311,9389,9418,943,9433,9443,9444,9445,95,9500,9527,9530,9550,9595,96,9600,9606,9633,9663,9682,9690,97,9704,9743,9761,9765,98,9800,981,9861,9869,9876,9898,9899,99,990,992,993,994,9943,9944,995,9950,9955,9966,9981,9988,999,9990,9991,9992,9993,9994,9997,9998,9999 -silent -o port_scan

echo -e "${GREEN}[+]Getting DNS details..${NC}"
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest > /dev/null 2>&1
cat naked_hosts.txt | dnsx -silent -a -resp -cname | tee dns_details.txt

echo -e "${GREEN}[+]Scanning for possible subdomain and mx takeovers${NC}"

wget "https://raw.githubusercontent.com/haccer/subjack/master/fingerprints.json" > /dev/null 2>&1

subjack -w naked_hosts.txt -t 100 -timeout 30 -o subtakeoverresults.txt -a -v -c ./fingerprints.json

cat final_subs.txt | mx-takeover -check-whois -w 64 -output mx-take-check.json

# cat naked_hosts.txt | while read domains do; do nslookup $domains | grep "canonical" ; done | tee cnames.txt

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

echo -e "${GREEN}[+]Gathering only the paths and pathQuery from urls...${NC}"

sleep 3

cat waygau.txt | unfurl format %s://%d%p >> only_paths.txt

cat waygau.txt | grep "?" | deduplicate --hide-useless -sort | sort -u | unfurl format %p?%q | tee path_query.txt

echo -e "${GREEN}[+]Deduplicating the urls...${NC}"

sleep 3

cat waygau.txt | deduplicate --hide-useless --sort >> deduped.txt

echo -e "${GREEN}[+] Crawling the subdomains using headless chrome${NC}"

# cat final_subs.txt | while read items do; do crawlergo_cmd -c /usr/bin/google-chrome -t 20 $items; done | tee crawlergo_results.txt

# cat crawlergo_results.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u >> crawled_urls.txt

# rm crawlergo_results.txt

cat only_paths.txt | grep "\.js$" >> jsfiles.txt

echo -e "${GREEN}Crawling using hakrawler..${NC}"

cat final_subs.txt | hakrawler -subs >> hakrawler_results.txt


echo -e "${GREEN}[+]Testing for ssrf from wayback URLS only...${NC}"

cat waygau.txt | grep "?" | grep "=" | qsreplace $COLLAB >> ssrfFuzz.txt

ffuf -c -w ssrfFuzz.txt -u FUZZ -t 300 -v -r 

cat waygau.txt | sort | uniq | grep "?" | qsreplace -a | qsreplace $COLLAB > ssrf2.txt

sed -i "s|$|\&dest=$2\&redirect=$2\&uri=$2\&path=$2\&continue=$2\&url=$2\&window=$2\&next=$2\&data=$2\&reference=$2\&site=$2\&html=$2\&val=$2\&validate=$2\&domain=$2\&callback=$2\&return=$2\&page=$2\&feed=$2\&host=$2&\port=$2\&to=$2\&out=$2\&view=$2\&dir=$2\&show=$2\&navigation=$2\&open=$2|g" $1-ssrf2.txt
echo "Firing the requests - check your server for potential callbacks"
ffuf -w ssrf2.txt -u FUZZ -t 50 -v -r

echo -e "${RED} Check your luck in collaborator.."

echo -e "${GREEN}Finding unfiltered characters using kxss...${NC}"

cat waygau.txt | grep "=" | kxss >> kxss_results.txt


echo -e "${GREEN}[+]Gathering for js files, links and secrets..${NC}"

sleep 5

cat final_subs.txt | getJS | httpx -silent | grep $TARGET >> js1.txt

cat waygau.txt | grep "\.js$" >> js2.txt

cat js1.txt js2.txt jsfiles.txt | sort -u >> jsurls.txt

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

echo -e "${RED}[+] Phewwww! Done...All the results are zipped. ***This is not the end, Please test remaining stuffs manually***${NC}"
