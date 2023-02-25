{
  open Parser

  let reserved = [
    (* Keywords *)
    ("let", fun i -> LET i);
    ("be", fun i -> BE i);
    ("in", fun i -> IN i);

    (* Symbols *)
    ("|", fun i -> VBAR i);
    ("+", fun i -> PLUS i);
    ("*", fun i -> TIMES i);
    ("^", fun i -> HAT i);
  ]

  (* Support functions *)

  type buildfun = info -> Parser.token
  let (symboltbl : (string, buildfun) Hashtbl.t) = Hashtbl.create 1024
  let _ = List.iter (fun (str, f) -> Hashtbl.add symbolTable str f) reserved

  let create_id id str =
    try (Hashtbl.find symboltbl str) id
    with _ ->
      let upper_case s =
        let first = (String.get s 0) in first >= 'A' && first <= 'Z' in
      if upper_case str then
         UCID {i = id; v = str}
      else
         LCID {i = id; v = str}

  let text = Lexing.lexeme
  let string_buf = ref (Bytes.create 2048)
  let string_end = ref 0
  let reset_str () = string_end := 0

  let add_str ch =
    let x = !string_end in
    let buffer = !string_buf in
    if x = Bytes.length buffer then begin
        let new_buf = Bytes.create (x * 2) in
        Bytes.blit buffer 0 new_buf 0 x;
        Bytes.set new_buf x ch;
        string_buf := new_buf;
        string_end := x + 1
    end else begin
        Bytes.set buffer x ch;
        string_end := x + 1
    end

  let get_str () = Bytes.sub_string (!string_buf) 0 (!string_end)
}

let white = [' ' '\t']+
let line_break = [' ' '\009' '\012']*"\n"

rule read = parse
  | white
    { read lexbuf }
  | line_break
    { read lexbuf }

  | ['0'-'9']+
    { INTV { i = info lexbuf; v = int_of_string (text lexbuf)} }

  | ['A'-'Z' 'a'-'z' '_']
  | ['A'-'Z' 'a'-'z' '_' '0'-'9' '\'']*
  | ['|' '+' '*' '^']
    { create_id (info lexbuf) (text lexbuf) }
