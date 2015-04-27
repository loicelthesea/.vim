find ./ -regex './.*/.git/config' -print -exec cat '{}' \; | grep url | sed 's/^.*url =/git clone/g' > bundle_load.sh && chmod +x bundle_load.sh
