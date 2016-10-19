find ./ -regex './bundle/.*/.git/config' -print -exec cat '{}' \; | grep url | sed 's/^.*url =/git clone/g' > bundle.load.sh && chmod +x bundle.load.sh
