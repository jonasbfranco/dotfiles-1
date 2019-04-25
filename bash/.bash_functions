# Docker
dlg () {
  docker exec -it $1 bash
}

# mpv
function mm() {
  params=\"$@\"
    mpv --really-quiet --profile=youtube ytdl://ytsearch10:"$params" > /dev/null 2>&1 &
    i3-msg '[class="mpv"] sticky enable' > /dev/null 2>&1
}

function mma() {
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
}

