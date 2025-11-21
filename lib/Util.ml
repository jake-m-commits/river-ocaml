open Spawn

(** Returns valid command to pass to Util.apply *)
let make_command map super x = map @ [ super; fst x ] @ snd x

(** Prints command for checking if passed command is valid *)
let pp command = print_endline @@ List.fold_left (fun x y -> x ^ " " ^ y) "" command

(* Use local install of riverctl *)
let riverctl = String.concat (Unix.getenv "HOME") [ ""; "/.local/bin/riverctl" ]

(** Launches riverctl with command arguments *)
let apply command = ignore @@ spawn ~prog:riverctl ~argv:command ()

(** Used to create tag function like "riverctl map normal Super 1 set-view-tags 1" *)
let make_tuples tags tag_f =
  let tag = List.map (fun x -> Int.to_string x) tags in
  List.map2 (fun x y -> x, y) tag tag_f
;;

(** Left bitwise shift to use tag *)
let lbs x = 1 lsl x |> Int.to_string
