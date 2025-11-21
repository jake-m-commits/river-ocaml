let map_normal = [ "riverctl"; "map"; "normal" ]
let map_pointer = [ "riverctl"; "map-pointer"; "normal" ]

(** Takes map, super key and list containing riverctl command;; calls riverctl *)
let def_map map super binds =
  let commands = List.map (fun x -> Util.make_command map super x) binds in
  List.iter Util.apply commands
;;

let tag_switch tags = List.map (fun x -> [ "set-focused-tags"; Util.lbs (x - 1) ]) tags
let tag_swap tags = List.map (fun x -> [ "set-view-tags"; Util.lbs (x - 1) ]) tags

(** Takes key for switching and key for swapping;;
 if you want more than 4 tags add floating points to tags list *)
let set_tags switch_key swap_key =
  let tags = [ 1; 2; 3; 4; 5; 6; 7; 8; 9 ] in
  def_map map_normal switch_key (Util.make_tuples tags @@ tag_switch tags);
  def_map map_normal swap_key (Util.make_tuples tags @@ tag_swap tags);
  (* Add 10th tag *)
  def_map map_normal switch_key (Util.make_tuples [ 0 ] @@ tag_switch [ 10 ]);
  def_map map_normal swap_key (Util.make_tuples [ 0 ] @@ tag_swap [ 10 ])
;;

let map_mouse super binds = def_map map_pointer super binds

(** Wrapper for def_map *)
let map_keys super binds = def_map map_normal super binds

(** Set keyboard repeat rate;; takes tuple of (rate, delay) *)
let repeat_rate tuple =
  let command =
    [ "riverctl"; "set-repeat"; Int.to_string (fst tuple); Int.to_string (snd tuple) ]
  in
  Util.apply command
;;
