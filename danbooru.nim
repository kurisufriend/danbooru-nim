import std/httpclient
import std/strformat
import std/json
import std/options
import std/sequtils
import std/strutils
import std/sugar

type
  danbooru* = object
    c: HttpClient
    endpoint*: string
  dbPost* = object
    id*: int
    uploader_id*: int
    approver_id*: Option[int]
    tag_string*: string
    tag_string_general*: string
    tag_string_artist*: string
    tag_string_copyright*: string
    tag_string_character*: string
    tag_string_meta*: string
    rating*: Option[string]
    parent_id*: Option[int]
    source*: string
    md5*: string
    file_url*: string
    large_file_url*: string
    preview_file_url*: string
    file_ext*: string
    file_size*: int
    image_width*: int
    score*: int
    fav_count*: int
    tag_count_general*: int
    tag_count_artist*: int
    tag_count_copyright*: int
    tag_count_character*: int
    tag_count_meta*: int
    last_comment_bumped_at*: Option[string]
    last_noted_at*: Option[string]
    has_children*: bool
    # is_note_locked*: bool
    # is_rating_locked*: bool
    # is_status_locked*: bool
    image_height*: int
    created_at*: string
    updated_at*: string
    

proc newDanbooru*(): danbooru =
  result.endpoint = "https://danbooru.donmai.us"
  result.c = newHttpClient()

proc post*(d: danbooru, id: int): dbPost =
  to(d.c.getContent(d.endpoint&fmt"/posts/{id}.json").parseJson(), dbPost)

proc searchPosts*(d: danbooru, tags: string, random: bool = false): seq[dbPost] =
  to(d.c.getContent(d.endpoint&fmt"/posts.json?tags="&tags&"&random=" & $random).parseJson(), seq[dbPost])


proc filterTags*(p: var seq[dbPost], tags: string): seq[dbPost] =
  let stags: seq[string] = tags.split(" ")
  p.filter((dbPost) => (
    for tag in stags:
      if not ((tag in dbPost.tag_string.split(" ")) or (tag[0] == '-' and tag[1 .. ^1] notin dbPost.tag_string.split(" "))):
        return false
    return true
  ))
