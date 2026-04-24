@define-color base {{ background }};
@define-color text {{ foreground }};
@define-color accent {{ accent }};
@define-color mantle {{ color0 }};
@define-color crust {{ color8 }};
@define-color red {{ color1 }};
@define-color yellow {{ color3 }};

* {
  border: none;
  border-radius: 0;
  font-family: "JetBrainsMono Nerd Font", monospace;
  font-size: 13px;
  min-height: 0;
}

window#waybar {
  background-color: alpha(@base, 0.8);
  color: @text;
  border-bottom: 2px solid @accent;
  border-radius: 10px;
}

#workspaces {
  background-color: @mantle;
  margin: 4px;
  border-radius: 6px;
}

#workspaces button {
  padding: 0 8px;
  color: @text;
  border-radius: 4px;
  transition: all 0.3s ease;
}

#workspaces button.active {
  background-color: @accent;
  color: @base;
  box-shadow: 0 0 5px @accent;
}

#workspaces button.urgent {
  background-color: @red;
}

#workspaces button:hover {
  background-color: alpha(@accent, 0.5);
}

#clock,
#battery,
#network,
#pulseaudio,
#tray,
#window,
#custom-update {
  padding: 0 10px;
  margin: 4px 2px;
  border-radius: 6px;
  background-color: @mantle;
}

#window {
  background-color: transparent;
  font-weight: bold;
}

#battery.charging {
  color: @yellow;
}

#battery.critical:not(.charging) {
  background-color: @red;
  color: @text;
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@keyframes blink {
  to {
    background-color: @text;
    color: @red;
  }
}

#custom-update {
  color: @accent;
}
