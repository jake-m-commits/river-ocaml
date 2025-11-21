let border_colour tuple =
  let focused = [ "riverctl"; "border-color-focused"; fst tuple ] in
  Util.apply focused;
  let unfocused = [ "riverctl"; "border-color-unfocused"; snd tuple ] in
  Util.apply unfocused
;;

let layout_config name =
  let manager = [ "riverctl"; "default-layout"; name ] in
  Util.apply manager
;;
