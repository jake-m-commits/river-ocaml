(** Add tag rule for app-id *)
let tag_rule tuple =
  let command =
    [ "riverctl"; "rule-add"; "-app-id"; fst tuple; "tags"; Int.to_string (snd tuple) ]
  in
  Util.apply command
;;
