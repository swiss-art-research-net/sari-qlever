#!/bin/sh
CHECKFILE=/status/.qlever-data-initialized
if [ ! -f $CHECKFILE ]; then
    echo "First time indexing"
    cd /index
    qlever-index -F nt -f /data/*.ttl -i qlever -s /init/settings.json -m '1 GB' -b '2 MB' -k false
    if [ $? -ne 0 ]; then
        echo "Indexing failed with a non-zero exit code. Exiting."
        exit 1
    fi
    touch $CHECKFILE
    echo "Indexing completed"
fi

# Start the QLever service
cd /index
qlever start --name qlever --description "$PROJECT_DESCRIPTION" --system native --port 7000 --access-token $ACCESS_TOKEN