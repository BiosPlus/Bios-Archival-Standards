#!/bin/bash
#
# Script to download personal youtube playlists via cron and then upload them via rclone to a remote:
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

#Globals
BASE_DIR="/home/bios/cron/Youtube"
OPERATION_DIR="$BASE_DIR/Personal-Playlists"
CACHE_DIR="$BASE_DIR/cache"

#Is it running?
RUN=`ps aux | grep *youtube-dl* | grep -v grep | wc -l`
if [[ $RUN -gt 0 ]]; 
    then echo "Yo what the fuck, Youtube-DL is already alive and doing something, I'm just going to leave it be."
    exit
fi

cd "$BASE_DIR"

youtube-dl \
-w \
-o "$OPERATION_DIR/Upload/Video/Youtube - Personal Playlists/%(playlist_uploader)s/%(playlist_title)s [%(playlist_id)s]/%(uploader)s [%(uploader_id)s]/%(upload_date)s - %(title)s/%(id)s/%(title)s.%(ext)s" \
-f bestvideo+bestaudio \
--all-subs --sub-format srt --convert-subs srt \
--ignore-errors \
--playlist-reverse \
--merge-output-format mkv --prefer-ffmpeg \
--add-metadata --write-description --write-info-json --write-annotations --write-thumbnail \
--embed-thumbnail \
--cache-dir="$CACHE_DIR" \
--download-archive="$OPERATION_DIR/youtube-dl-done.txt" \
https://www.youtube.com/playlist?list=REDACTED

sudo rclone move "$OPERATION_DIR/Upload/Video/" drive:Filezor/Media/Video/ -P --delete-empty-src-dirs --stats-file-name-length 150 -v --drive-chunk-size 256M

exit
