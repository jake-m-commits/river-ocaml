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

(** Set accel profile for input device (none || flat || adaptive) *)
let accel_profile ~device ~profile =
  if
    String.equal profile "none"
    || String.equal profile "flat"
    || String.equal profile "adaptive"
  then (
    let command = input_add @ [ device; "accel-profile"; profile ] in
    Util.apply command)
  else failwith "Unknown input profile. Use none || flat || adaptive."
;;

(** Set pointer accel for input device (1. > factor > -1.) *)
let pointer_accel ~device ~factor =
  if factor > Float.neg 1. || factor < 1.
  then (
    let command = input_add @ [ device; "pointer-accel"; string_of_float factor ] in
    Util.apply command)
  else failwith "Invalid factor. Use a accel factor between -1 and 1."
;;
