case "$1" in
    up)
        amixer set Master 5%+ ;;
    down)
        amixer set Master 5%- ;;
    mute)
        amixer set Master toggle ;;
    *)
        echo "Usage: $0 {up|down|mute}" ;;
esac