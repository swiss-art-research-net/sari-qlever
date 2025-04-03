#!/bin/sh
CHECKFILE=/status/.qlever-data-initialized
if [ ! -f $CHECKFILE ]; then
    echo "First time indexing"
    cd /index
    IndexBuilderMain -F nt -f /data/*.ttl -i qlever -s /init/settings.json -m '1 GB' -b '2 MB' -k false
    if [ $? -ne 0 ]; then
        echo "Indexing failed with a non-zero exit code. Exiting."
        exit 1
    fi
    touch $CHECKFILE
    echo "Indexing completed"
fi

# Start the QLever service
cd /index
ServerMain -i qlever -j 8 -p 7000 -m 5G -c 2G -e 1G -k 200 -s 30s -a $ACCESS_TOKEN