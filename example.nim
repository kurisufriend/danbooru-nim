import danbooru

var db = newDanbooru()
echo(db.endpoint)
var mai_waifu = db.returnTaggedPosts("makise_kurisu rating:safe", "1girl -1boy -2girl -futanari -sex_toy -cosplay -tattoo", num = 600)
for post in mai_waifu:
  echo(post.file_url)

