@define-color foreground {{ foreground }};
@define-color background {{ background }};

* {
  border: none;
  border-radius: 0;
  font-family: "JetBrainsMono Nerd Font", monospace;
  font-size: 13px;
  min-height: 0;
}

window#waybar {
  background-color: @background;
  color: @foreground;
}

#workspaces {
  margin: 0 5px;
}

#workspaces button {
  padding: 0 5px;
  color: @foreground;
  border-radius: 4px;
}

#workspaces button.active {
  background-color: {{ accent }};
  color: {{ background }};
}

#workspaces button.urgent {
  background-color: {{ color1 }};
}

#clock,
#battery,
#network,
#pulseaudio,
#tray,
#idle_inhibitor,
#window {
  padding: 0 10px;
  margin: 3px 3px;
  border-radius: 8px;
  background-color: rgba(0, 0, 0, 0.2);
}