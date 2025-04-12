(* definition of btree datatype *)
datatype btree = Empty | Leaf | Node of int * btree * btree

(* create a tree based on the list *)
fun buildTree (a : int list, index : int ref) : btree =
    case !index < List.length a of
        false => Empty
    |   true =>
        let
            val value = List.nth (a, !index)
            val () = index := !index + 1
        in
            if value = 0 then Empty
            else Node (value, buildTree (a, index), buildTree (a, index))
        end

(* swap operation on a specific node *)
fun swapOp (t : btree) : btree =
    case t of
        Empty => Empty
    |   Node (x, left, right) => Node (x, right, left)

(* create the best tree in the world *)
fun swap (t : btree) : btree * int =
    case t of
        Empty => (Empty, 0)
    |   Node (x, left, right) =>
        let
            val (swapLeft, leftData) = swap left
            val (swapRight, rightData) = swap right
        in
            if leftData = 0 andalso rightData = 0 then (Node(x, swapLeft, swapRight), x)
            else if leftData = 0 andalso rightData <> 0 then
                if rightData < x then (
                    let
                        val newNode = swapOp (Node(x, swapLeft, swapRight))
                    in
                        (newNode, rightData)
                    end
                )
                else (Node(x, swapLeft, swapRight), x)
            else if leftData <> 0 andalso rightData = 0 then
                if x < leftData then (
                    let
                        val newNode = swapOp (Node(x, swapLeft, swapRight))
                    in
                        (newNode, x)
                    end
                )
                else (Node(x, swapLeft, swapRight), leftData)
            else
                if rightData < leftData then (
                    let
                        val newNode = swapOp (Node(x, swapLeft, swapRight))
                    in
                        (newNode, rightData)
                    end
                )
                else (Node(x, swapLeft, swapRight), leftData)
        end

(* print the best tree in the world *)
fun printTree (t : btree, k : int ref) : unit =
    case t of
        Empty => ()
    |   Node (x, left, right) => (
            printTree (left, k);
            if !k = 1 then TextIO.print (Int.toString x ^ "\n")
            else (TextIO.print (Int.toString x ^ " "));
            k := !k - 1;
            printTree (right, k)
    )

(* arrange function *)
fun arrange (fileName : string) =
    let
        val inputFileName = TextIO.openIn fileName
        (* open the input file and read the first line *)
        val str1 = TextIO.inputLine inputFileName
    in
        case str1 of
            NONE => TextIO.print("Error: Unable to read from the input file")
        |   SOME s1 =>
            let
                val N = Int.fromString s1
                in
                    case N of
                        NONE => TextIO.print("Error: Unable to parse ")
                    |   SOME n =>
                        let
                            val str2 = TextIO.inputLine inputFileName
                            (* read the second line of the input file *)
                        in
                            case str2 of
                                NONE => TextIO.print("Error: Unable to read from the input file")
                            |   SOME s2 =>
                                let
                                    val a = map(fn str => case Int.fromString str of
                                        NONE => 0
                                    |   SOME s => s) (String.tokens (fn c => c = #" ") s2)
                                    val oldTree = buildTree (a, ref 0)
                                    val (newTree, _) = swap oldTree
                                    (* load the tree from the input file to a list *)
                                    (* create the tree based on the list *)
                                    (* create the best tree in the world *)

                                in
                                    (* and print it *)
                                    printTree (newTree, ref n)
                                end
                        end
            end
    end