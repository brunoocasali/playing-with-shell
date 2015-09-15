# Say: never more! to your crazy dependencies on maven! :D

find ~/.m2  -name "*.lastUpdated" -exec grep -q "Could not transfer" {} \; -print -exec rm {} \;

git rm --cached `git ls-files -i --exclude-from=.gitignore`
