{ pkgs, ... }:

{
  programs.waybar.style = ''
    * {
        font-family: "Ubuntu Nerd Font";
        font-size: 13px;
        min-height: 0;
    }

    window#waybar {
        /* background: transparent; */
        /* background: black; */
        background: rgba(40, 44, 52, 0.85);
        color: white;
        border: 1px solid #8fd4ff;
        border-radius: 10px;
    }

    #window {
        font-family: "Ubuntu";
    }

    #workspaces button.focused {
        color: white;
        border: 1px solid #8fd4ff;
        border-radius: 10px;
    }

    #tray,
    #custom-japan,
    #custom-brazil,
    #temperature,
    #clock,
    #battery,
    #cpu,
    #memory,
    #network,
    #pulseaudio {
        padding: 0 5px;
        margin-right: 5px;
        margin-top: 5px;
        margin-bottom: 5px;
    }

    #temperature.critical {
        color: #b62d66;
    }

    #battery icon {
        color: #b62d66;
    }

    #battery.charging {
        border-bottom: 1px dotted #8fd4ff;
    }

    @keyframes blink {
        to {
            background-color: #8fd4ff;
            color: black;
        }
    }

    #battery.warning:not(.charging) {
        color: white;
        animation-name: blink;
        animation-duration: 2s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        border-radius: 5px;
    }

    #battery.warning:not(.charging) {
        color: white;
        animation-name: blink;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        border-radius: 5px;
    }

    #network.disconnected {
        color: #b62d66;
    }'';
}
