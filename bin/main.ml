open! Config

(*Define super keys*)
let super = "Super"
let super_shifted = "Super+Shift"

(*Config for layout manager*)
let wideriver_config =
  "wideriver --layout left --layout-alt monocle --stack even --count-master 1 \
   --ratio-master 0.6 --count-wide-left 0 --ratio-wide 0.35 --smart-gaps --inner-gaps 4 \
   --outer-gaps 4 --border-width 2 --border-width-monocle 0 --border-width-smart-gaps 0 \
   --border-color-focused 0x76946A --border-color-focused-monocle 0x000000 \
   --border-color-unfocused 0x2A2A37 --log-threshold info"
;;

let binds =
  [ "Q", [ "close" ]
  ; "F", [ "toggle-fullscreen" ]
  ; "D", [ "spawn"; "fuzzel" ]
  ; "J", [ "focus-view"; "next" ]
  ; "K", [ "focus-view"; "previous" ]
  ; "Return", [ "spawn"; "foot" ]
  ; "Space", [ "toggle-float" ]
  ]
in
Keybinds.map_keys super binds;
let binds_shifted =
  [ "E", [ "exit" ]
  ; "J", [ "swap"; "next" ]
  ; "K", [ "swap"; "previous" ]
  ; ( "P"
    , [ "spawn"
      ; "grim -g \"$(slurp)\" ~/Pictures/screenshots/$(date \
         +\"%Y-%m-%d_%Hh%Mm%Ss_grim.png\")"
      ] )
  ; ( "U"
    , [ "spawn"; "swaylock -F -f -c 000000 -i ~/Pictures/walls/ultra-wide/BLACK_II.jpg" ]
    )
  ]
in
Keybinds.map_keys super_shifted binds_shifted;
let mouseKeybinds = [ "BTN_LEFT", [ "move-view" ]; "BTN_RIGHT", [ "resize-view" ] ] in
Keybinds.map_mouse super mouseKeybinds;
(*Sets tag switching with Super and Super+Shift keys*)
Keybinds.set_tags super super_shifted;
Keybinds.repeat_rate (75, 300);
Decorations.border_colour ("0x76946A", "0x2A2A37");
(*Wrapper for riverctl default-layout*)
Decorations.layout_config "wideriver";
(*Hacky way to launch apps on startup*)
let autostart =
  [ "pipewire"
  ; "mako"
  ; "/usr/lib/xdg-desktop-portal-wlr -r"
  ; "/usr/lib/xdg-desktop-portal -r"
  ; "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""
  ; "gsettings set org.gnome.desktop.interface icon-theme \"Papirus\""
  ; "gsettings set org.gnome.desktop.interface cursor-theme \"Nerissa-Ravencroft\""
  ; "gsettings set org.gnome.desktop.interface cursor-size \"24\""
  ; "gsettings set org.gnome.desktop.interface font-name \"Berkeley Mono\""
  ; "wlr-randr --output DP-1 --mode 3440x1440@164.899994Hz"
  ; "swaybg -i ~/Pictures/walls/ultra-wide/hint-of-pink.png -m fill"
  ; "waybar -c ~/.config/waybar-river/config -s ~/.config/waybar-river/style.css"
  ; "notify-send -t 8000 -i \"$(find $HOME/.mako-art -type f | shuf -n 1)\" \"Welcome \
     $USER!\" &> /dev/null &"
  ; wideriver_config
  ]
in
List.iter (fun x -> Util.apply @@ [ "riverctl"; "spawn" ] @ [ x ]) autostart;
(*If you want to apply something with riverctl, use Util.apply*)
(* Util.apply [ "riverctl"; "keyboard-layout"; "-options"; "ctrl:nocaps,grp:toggle"; "us" ]; *)

(*Scratchpad on tag #5 with tag-mask*)
Util.apply [ "riverctl"; "map"; "normal"; "Super"; "I"; "toggle-focused-tags"; "16" ];
Util.apply [ "riverctl"; "map"; "normal"; "Super+Shift"; "I"; "set-view-tags"; "16" ];
Util.apply [ "riverctl"; "spawn-tagmask"; "16" ];
Util.apply [ "riverctl"; "focus-follows-cursor"; "always" ]
