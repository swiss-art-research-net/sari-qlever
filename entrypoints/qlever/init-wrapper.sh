#!/bin/sh
CHECKFILE=/status/.qlever-data-initialized
if [ ! -f $CHECKFILE ]; then
    echo "First time indexing"
    cd /index
    qlever-index --file-format nt --kg-input-file /data/*.ttl --index-basename qlever --settings-file /init/settings.json --stxxl-memory '1 GB' --parser-buffer-size '2 MB' --keep-temporary-files false --text-words-from-literals
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