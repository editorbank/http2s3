# For debug message
curl -D- http://localhost:81/$1
curl -fs -o /dev/null http://localhost:81/$1 &&echo -e "\nOK" || echo -e "\nFAIL"
