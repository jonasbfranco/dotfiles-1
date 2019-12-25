# Docker
dlg () {
  docker exec -it $1 bash
}

dbl () {
    docker build -t $1 .
}

dru () {
    docker run --name $1 --network host -itd $2
}

# mpv
function mm() {
	params=\"$@\"
	killall mpv 1> /dev/null 2> /dev/null
	sleep 1
    #(mpv --really-quiet --profile=youtube ytdl://ytsearch10:"$params") > /dev/null 2>&1 &
	#(mpv --really-quiet --profile=youtube ytdl://ytsearch10:"$params") > /dev/null 2> /dev/null &
	(mpv --really-quiet --profile=youtube-cache ytdl://ytsearch:"$params") > /dev/null 2> /dev/null &

	#i3-msg '[class="mpv"] sticky enable' > /dev/null 2> /dev/null &

    #mpv --really-quiet --profile=youtube ytdl://ytsearch10:"$params" > /dev/null 2>&1 &
    #i3-msg '[class="mpv"] sticky enable' > /dev/null 2>&1
}

function mma() {
    #mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch:"$@"
}

# mp3
bitrate () {
    echo `basename "$1"`: `file "$1" | sed 's/.*, \(.*\)kbps.*/\1/' | tr -d " " ` kbps
}
