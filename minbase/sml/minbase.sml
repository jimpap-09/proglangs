(*
NOTIFICATION!!!
we used stack-overflow and chat-gpt
to guide us on our journey with sml
*)
(* find_digits_in_base function *)
fun find_digits_in_base n b =
    let
        fun aux 0 acc = acc (* until we reach 0, so we return the list *)
            | aux n acc = aux (n div b) ((n mod b) :: acc) (* we recursively add the (n mod b) on that list *)
    in
        aux n [] (* start with empty list *)
    end

(* all_digits_same function *)
fun all_digits_same [x] = true (* if xs is empty then true *)
    | all_digits_same (x::y::xs) = (x = y) andalso all_digits_same (y::xs)
    (* extract x, y from the input list and check if they the same, then do the same for the y::xs list*)

(* find_smallest_base function *)
fun find_smallest_base n =
    let
        fun find_base b =
            let
                val digits = find_digits_in_base n b (* find the digits of number n in base b *)
            in
                if all_digits_same digits then b (* if they are all the same then the minbase of number n is b *)
                else find_base (b+1) (* otherwise check the requirements for the next base *)
            end
    in
        find_base 2 (* start checking from base = 2 if the requirements are completed, if not go on to the next base *)
    end

(* minbases function *)
fun minbases numbers =
    let
        (* print_min_bases function *)
        fun print_min_bases [] = ()
            | print_min_bases (n::ns) =
                (print (Int.toString (find_smallest_base n) ^ "\n");
                print_min_bases ns)
    in
        print_min_bases numbers (* for each number in numbers find the smallest base of that number *)
    end