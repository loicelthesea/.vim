find ./ -regex './.*/.git/config' -print -exec cat '{}' \; | grep url | sed 's/^.*url =/git clone/g' > bundles.clone.sh && chmod +x bundles.clone.sh
