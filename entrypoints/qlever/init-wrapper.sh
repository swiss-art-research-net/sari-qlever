#!/bin/sh
if [ ! -f /init/.initialized ]; then
    echo "First time indexing"
    cd /index
    IndexBuilderMain -F nt -f *.ttl -i qlever -s /init/settings.json -m '1 GB' -b '2 MB' -k false
    touch /init/.initialized
    echo "Indexing completed"
fi

# Start the QLever service
cd /index
ServerMain -i qlever -j 8 -p 7000 -m 5G -c 2G -e 1G -k 200 -s 30s -a $ACCESS_TOKEN