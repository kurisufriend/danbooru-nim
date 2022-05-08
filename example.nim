import danbooru

var db = newDanbooru()
echo(db.endpoint)
var mai_waifu = db.searchPosts("makise_kurisu", random = true)
mai_waifu = mai_waifu.filterTags("1girl -1boy -2girl -futanari -sex_toy -cosplay -tattoo")
for post in mai_waifu:
    echo(post.file_url)
