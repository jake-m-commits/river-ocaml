let input_add = [ "riverctl"; "input" ]

let enable_tap device =
  let command = input_add @ [ device; "tap"; "enabled" ] in
  Util.apply command
;;

let enable_drag_lock device =
  let command = input_add @ [ device; "drag-lock"; "enabled" ] in
  Util.apply command
;;

let enable_natural_scroll device =
  let command = input_add @ [ device; "natural-scroll"; "enabled" ] in
  Util.apply command
;;

let enable_two_finger_scroll device =
  let command = input_add @ [ device; "scroll-method"; "two-finger" ] in
  Util.apply command
;;
