open! Config

(* Define super keys *)
let super = "Super"
let super_shifted = "Super+Shift"

(* Config for layout manager *)
let wideriver_config =
  "wideriver --layout right --layout-alt monocle --stack even --count-master 1 \
   --ratio-master 0.6 --count-wide-left 0 --ratio-wide 0.35 --no-smart-gaps --inner-gaps \
   0 --outer-gaps 0 --border-width 2 --border-width-monocle 2 --border-width-smart-gaps \
   2 --border-color-focused 0xb36d43 --border-color-focused-monocle 0xb36d43 \
   --border-color-unfocused 0x000000 --log-threshold info"
;;

(* Configure input devices *)
let ploopy_touchpad =
  "pointer-65261-0-Ploopy_Corporation_Ploopy_Pavonis_Trackpad_Touchpad"
in
let zsa_navigator = "pointer-12951-6519-ZSA_Technology_Labs_Voyager" in
Input.enable_tap ploopy_touchpad;
Input.enable_drag_lock ploopy_touchpad;
Input.enable_natural_scroll ploopy_touchpad;
Input.enable_two_finger_scroll ploopy_touchpad;
Input.accel_profile ~device:zsa_navigator ~profile:"flat";
Input.pointer_accel ~device:zsa_navigator ~factor:0.25;
Keybinds.repeat_rate (75, 300);
(* Apply rules *)
Rules.ssd_rule "*";
Rules.tag_rule ("firefox", 1);
Rules.tag_rule ("JDS Labs Core", 3);
Rules.tag_rule ("foot-wiremix", 3);
Rules.tag_rule ("org.qbittorrent.qBittorrent", 7);
Rules.tag_rule ("steam", 8);
Rules.float_rule "vpn-stat";
Rules.float_rule "floating-foot";
(* Apply keybinds *)
let binds =
  [ "Q", [ "close" ]
  ; "F", [ "toggle-fullscreen" ]
  ; "D", [ "spawn"; "fuzzel" ]
  ; "J", [ "focus-view"; "next" ]
  ; "K", [ "focus-view"; "previous" ]
  ; "Return", [ "spawn"; "ghostty" ]
  ; "Space", [ "toggle-float" ]
  ]
in
Keybinds.map_keys super binds;
let binds_shifted =
  [ "E", [ "exit" ]
  ; "J", [ "swap"; "next" ]
  ; "K", [ "swap"; "previous" ]
  ; "Return", [ "spawn"; "foot" ]
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
Keybinds.set_tags super super_shifted;
(* Apply decorations *)
Decorations.border_colour ("0xb36d43", "0x000000");
Decorations.layout_config "wideriver";
(* Auto-start *)
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
  ; "swaybg -i ~/Pictures/walls/ultra-wide/hint-of-pink.png -m fill -c 000000"
  ; "waybar -c ~/.config/waybar-river/config -s ~/.config/waybar-river/style.css"
  ; "notify-send -t 8000 -i \"$(find $HOME/.mako-art -type f | shuf -n 1)\" \"Welcome \
     $USER!\" &> /dev/null &"
  ; wideriver_config
  ; "firefox"
  ; "foot-wiremix"
  ; "qbittorrent"
  ; "steam"
  ]
in
List.iter (fun x -> Util.apply @@ [ "riverctl"; "spawn" ] @ [ x ]) autostart;
(* If you want to apply something with riverctl, use Util.apply *)
(* Util.apply [ "riverctl"; "keyboard-layout"; "-options"; "ctrl:nocaps,grp:toggle"; "us" ]; *)

(* Scratchpad *)
Util.apply [ "riverctl"; "map"; "normal"; "Super"; "I"; "spawn"; "river-toggle-scratch" ];
Util.apply
  [ "riverctl"; "map"; "normal"; "Super+Shift"; "I"; "set-view-tags"; Util.lbs 20 ];
Util.apply
  [ "riverctl"; "spawn-tagmask"; ((1 lsl 32) - 1) lxor (1 lsl 20) |> Int.to_string ];
(* Other *)
Util.apply [ "riverctl"; "focus-follows-cursor"; "always" ];
Util.apply [ "riverctl"; "xcursor-theme"; "Nerissa-Ravencroft"; "24" ];
Util.apply [ "riverctl"; "set-cursor-warp"; "on-focus-change" ]
