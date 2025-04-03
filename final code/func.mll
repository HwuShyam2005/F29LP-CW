(* File func.mll *)

{
type token = 
    | METHOD | ENDMETHOD | VARS | BEGIN | END | RETURN | IF | THEN | ELSE | ENDIF |
    WHILE | BEGINWHILE | ENDWHILE | READ | WRITE | LESS | LESSEQ | EQ | NEQ 
    | ID of string | INT of int | SEMICOLON | COMMA | ASSIGN | LEFTPARANTHESIS 
    | RIGHTPARANTHESIS  | EOF
    
    exception LEX of string
}

let digit = ['0' - '9']
let letter = ['a' - 'z' 'A' - 'Z']
let id = letter (letter | digit | '_')*

rule token = parse
    | [' ' '\t' '\n']   { token lexbuf }
    | "method"         { METHOD }
    | "endmethod"      { ENDMETHOD }
    | id as s          { ID s }
    | digit+ as d      { INT (int_of_string d) }
    | "vars"           { VARS }
    | "begin"          { BEGIN }
    | "end"            { END }
    | "return"         { RETURN }
    | "if"             { IF }
    | "then"           { THEN }
    | "else"           { ELSE }
    | "endif"          { ENDIF }
    | "while"          { WHILE }
    | "beginwhile"     { BEGINWHILE }
    | "endwhile"       { ENDWHILE }
    | "read"           { READ }
    | "write"          { WRITE }
    | "less"           { LESS }
    | "lessEq"         { LESSEQ }
    | "eq"             { EQ }
    | "nEq"            { NEQ }
    | ";"              { SEMICOLON }
    | ","              { COMMA }
    | ":="             { ASSIGN }
    | "("              { LEFTPARANTHESIS }
    | ")"              { RIGHTPARANTHESIS }
    | eof              { EOF }
    | _ {  raise (LEX ("Unexpected char: " ^ Lexing.lexeme lexbuf))  }