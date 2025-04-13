(* 
   Prints all integers from n down to 1. 
   If n < 1, it does nothing. Otherwise, it prints n 
   and then recursively calls itself on n-1.
*)
fun count_down n =
  if n < 1 then ()
  else (print (Int.toString n ^ "\n");
        count_down (n-1))

(*
   Prints all integers from 1 up to n.
   If n < 1, it does nothing. Otherwise, it first recursively prints 
   integers from 1 up to n-1, then prints n. Not tail-recursive.
*)
fun count_up n =
  if n < 1 then ()
  else (count_up (n-1);
        print (Int.toString n ^ "\n"))


(*
   Prints all integers starting at [from] and ending at [upto]. 
   If 'from' > 'upto', it does nothing. Otherwise, it prints 'from' 
   and recurses with (from+1).
*)
fun countUpTo from upto =
  if from > upto then ()
  else (print (Int.toString(from) ^ "\n"); countUpTo (from+1) upto);

(*
   Example of partial application.
   count1 is a function that, given n, prints all integers from 1 up to n.
*)
val count1 = countUpTo 1;


(* Exercise 3 from the lab tutorial

   First attempt:
   --------------
   Create a function that splits a list at a given index and then call it with
   (length l + 1) div 2. This requires two passes over the list: one for
   computing the length, and another for splitting.

*)

fun splitAt l 0 = ([], l)
  | splitAt [] _ = ([], [])
  | splitAt (x::xs) n =
    let 
      val (left, right) = splitAt xs (n-1)
    in
      (x::left, right)  
    end

fun split l = 
  let 
    val k = (length l + 1) div 2 
  in 
    splitAt l k
  end

val test1 = split [1,2,3,4,5] = ([1,2,3], [4,5])
val test2 = split [42,42,42,42] = ([42,42], [42,42])


(*
   Second attempt:
   ---------------
   Achieves the same split in a single pass using an internal helper
   (splitClever). It traverses two lists in parallel: the original list 'lst'
   and a tracking list 't2' that allows us to position the "split" halfway.
*)

fun split2 (lst : int list) = 
  let
    fun splitClever lst [] = ([], lst)
      | splitClever (h::t) (_::[]) = ([h], t)
      | splitClever (h::t) (_::_::t2) = 
          let
            val (left, right) = splitClever t t2
          in 
            (h::left, right)
          end
  in
    splitClever lst lst
  end 

val test1 = split2 [1,2,3,4,5] = ([1,2,3], [4,5])
val test2 = split2 [42,42,42,42] = ([42,42], [42,42])

(* Exercise 6 from the practice problems *)

(*
   A datatype for arithmetic expressions:
     - IntLit n: integer literal
     - Plus(e1, e2): addition of two expressions
     - Minus(e1, e2): subtraction of two expressions
     - Mult(e1, e2): multiplication of two expressions
     - Div(e1, e2): integer division of two expressions
*)

datatype expr = IntLit of int
              | Plus of expr * expr
              | Minus of expr * expr 
              | Mult of expr * expr 
              | Div of expr * expr 


(* 
   An interpreter that evaluates an arithmetic expression to an integer result
*)
fun eval (IntLit n) = n
  | eval (Plus (e1,e2)) = eval e1 + eval e2
  | eval (Minus (e1,e2)) = eval e1 - eval e2
  | eval (Mult (e1,e2)) = eval e1 * eval e2
  | eval (Div (e1,e2)) = eval e1 div eval e2


val res = eval (Plus (Mult (IntLit 5, IntLit 5), IntLit 17))