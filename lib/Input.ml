let input_add = [ "riverctl"; "input" ]

(** Enable tap for input device *)
let enable_tap device =
  let command = input_add @ [ device; "tap"; "enabled" ] in
  Util.apply command
;;

(** Enable drag lock for input device *)
let enable_drag_lock device =
  let command = input_add @ [ device; "drag-lock"; "enabled" ] in
  Util.apply command
;;

(** Enable natural scroll for input device *)
let enable_natural_scroll device =
  let command = input_add @ [ device; "natural-scroll"; "enabled" ] in
  Util.apply command
;;

(** Set scroll method to two finger for input device *)
let enable_two_finger_scroll device =
  let command = input_add @ [ device; "scroll-method"; "two-finger" ] in
  Util.apply command
;;
