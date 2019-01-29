# ffmpeg string for archiving triple j's radio stream into 30 minute chunks, automatic date and time-stamping.
# (was used for the hottest 100 of 2018 and 2019)
# ensure that you grab the newest stream address by downloading an AAC+ pls file (higher bit-rate), opening that in a text editor and grabbing one of the stream links.
# "-strict -2" is used to enable experimental functionailty for ffmpeg, this was needed for the 2018 stream to enable aac transcoding.
# you may want to experiment with HE-AAC (https://trac.ffmpeg.org/wiki/Encode/AAC#fdk_he)

ffmpeg -i http://audiostream.c3.abc.net.au/hottest100_a_aac -f segment -segment_time 00:30:00 -strftime 1  -c copy -strict -2 "Triple J Hottest 100 %Y (%m - %d) - %H-%M-%S.aac"
