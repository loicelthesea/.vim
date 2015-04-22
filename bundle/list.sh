find ./ -name config -exec cat '{}' \; | grep url | sed 's/^.*url =/git clone/g' > load.sh && chmod +x load.sh
