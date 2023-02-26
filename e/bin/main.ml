let show _ = failwith "todo: show"
let succeed = function E.Syntax.Num i -> Printf.printf "%d\n" i

let fail text buffer _ =
  let location =
    MenhirLib.LexerUtil.range (MenhirLib.ErrorReports.last buffer)
  in
  let indication =
    Format.sprintf "Syntax error %s.\n"
      (MenhirLib.ErrorReports.show (show text) buffer)
  in
  Format.eprintf "%s%s%!" location indication;
  exit 1

let parse lexbuf text : unit =
  let supplier =
    E.Parser.MenhirInterpreter.lexer_lexbuf_to_supplier E.Lexer.read lexbuf
  in
  let buffer, supplier = MenhirLib.ErrorReports.wrap_supplier supplier in
  let checkpoint = E.Parser.Incremental.start lexbuf.lex_curr_p in
  E.Parser.MenhirInterpreter.loop_handle succeed (fail text buffer) supplier
    checkpoint

let get_contents s =
  let filename, content =
    match s with
    | None | Some "-" -> ("-", In_channel.input_all In_channel.stdin)
    | Some filename -> (filename, Stdio.In_channel.read_all filename)
  in
  (MenhirLib.LexerUtil.init filename (content |> Lexing.from_string), content)

let loop filename =
  let lexbuf, content = get_contents filename in
  parse lexbuf content

let () =
  let usage = "e <file1> [<file2>] ..." in
  let filename = ref None in
  let readfname fname =
    filename := if String.length fname > 0 then Some fname else None
  in
  Arg.parse [] readfname usage;
  loop !filename
