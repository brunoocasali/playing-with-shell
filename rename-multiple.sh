a=1
for i in *.jpg; do
  new=$(printf "%04d.jpg" "$a")
  mv -- "$i" "$new"
  let a=a+1
done

# will get all *.jpg files and rename to a sequence starting in `a`.
# => `0001.jpg`, `0002.jpg`, `0003.jpg`
