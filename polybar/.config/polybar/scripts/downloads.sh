# downloads.sh

if [ "$1" == "c" ]; then
	killall youtube-dl
elif [ "$1" == "x" ]; then
	bash -c "$HOME/bin/videodown.sh"
elif [ "$1" == "i" ]; then
	bash -c "$HOME/bin/imgdown.sh"
else 
	videos=$(ps -A | grep youtube-dl | wc -l)
	imagens=$(ps -ef | grep imgdown.sh | grep -v grep | wc -l)
	
	if [ $videos -gt 0 ] && [ $imagens -gt 0 ]; then
		echo "%{F#D08770}%{F-} $videos / $imagens"
	elif [ $videos -gt 0 ] && [ $imagens -eq 0 ]; then
		echo "%{F#D08770}%{F-} $videos"
	elif [ $videos -eq 0 ] && [ $imagens -gt 0 ]; then
		echo "%{F#D08770}%{F-} $imagens"
	else
		echo "%{F#D08770}%{F-}"
	fi
fi