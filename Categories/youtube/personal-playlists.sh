#!/bin/bash
#
# Script to download personal youtube playlists via cron:
# Heads Up: 
# - This script presumes the playlist is visible to the public
# - Using this presumes you've read the documentation @ http://rg3.github.io/youtube-dl/
# - This uses the srt subtitle format, without embedding it into the file, as it's widely compatible and very robust
# - While embeding thumbnails is not compatible with .mkv files, this future proofs in the event youtube-dl will enable support for it, else it writes the thumbnail to the folder.
#
# Requirements:
# - ffmpeg
# - youtube-dl
#
# Setup:
# Replace the path under the "BASE_DIR" variable to the directory where you want to operate youtube-dl from, ensure that the folder has write access for your user.
#

BASE_DIR="/path/to/dir"

youtube-dl \
-w \
-o "$BASE_DIR/Upload/Video/Youtube - Personal Playlists/%(playlist_uploader)s/%(playlist_title)s [%(playlist_id)s]/%(uploader)s [%(uploader_id)s]/%(upload_date)s - %(title)s/%(id)s/%(title)s.%(ext)s" \
-f bestvideo+bestaudio \
--all-subs --sub-format srt --convert-subs srt \
--ignore-errors \
--playlist-reverse \
--merge-output-format mkv --prefer-ffmpeg \
--add-metadata --write-description --write-info-json --write-annotations --write-thumbnail \
--embed-thumbnail \
--cache-dir="$BASE_DIR/cache" \
--download-archive="$BASE_DIR/youtube-dl-done.txt" \
https://www.youtube.com/playlist?list=PLAYLIST_ID_HERE
