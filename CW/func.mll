(* File func.mll *)
{
type token =
  | EOF
  | METHOD | VARS | BEGIN | ENDMETHOD | RETURN
  | READ | WRITE
  | IF | THEN | ELSE | ENDIF
  | WHILE | BEGIN_WHILE | ENDWHILE
  | LPAREN | RPAREN | COMMA | SEMICOLON
  | ASSIGN
  | PLUS | TIMES | MINUS | DIVIDE
  | LESS | LESSEQ | EQ | NEQ
  | ID of string
  | INT of int
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let id = alpha (alpha | digit)*

rule token = parse
  | [' ' '\t' '\n'] { token lexbuf }  (* Skip whitespace *)
  | "method" { METHOD }
  | "vars" { VARS }
  | "begin" { BEGIN }
  | "endmethod" { ENDMETHOD }
  | "return" { RETURN }
  | "read" { READ }
  | "write" { WRITE }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | "endif" { ENDIF }
  | "while" { WHILE }
  | "begin" { BEGIN_WHILE }
  | "endwhile" { ENDWHILE }
  | "plus" { PLUS }
  | "times" { TIMES }
  | "minus" { MINUS }
  | "divide" { DIVIDE }
  | "less" { LESS }
  | "lessEq" { LESSEQ }
  | "eq" { EQ }
  | "nEq" { NEQ }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ',' { COMMA }
  | ';' { SEMICOLON }
  | ":=" { ASSIGN }
  | id as i { ID i }
  | digit+ as n { INT (int_of_string n) }
  | eof { EOF }
  | _ { raise (Failure ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }