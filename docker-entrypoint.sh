#!/bin/bash
#
cd /plugins
cp *.go /tmp
for file in /tmp/*.go;                                         \
        do                                                    \
                if [ -e "$file" ]; then                       \
                        echo "Making so for $file"  &&                \
                        so=$(echo $file | sed 's/\.go$/\.so/g') &&    \
                        go build -v -buildmode=plugin -o $so $file && \
                        rm $file ;                                    \
                fi                                            \
        done
sleep 10
mongo "$LAIRDB_HOST":27017/admin --eval "var lairdbHost = '$LAIRDB_HOST'" /scripts/db_init.js
sleep 1
api-server