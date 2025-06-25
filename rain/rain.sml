(* rain.sml sourse code *)

(* find the maximum to the left *)
fun prefixMax [] = []
  | prefixMax (x::xs) = 
    let
      fun aux ([], acc) = []
        | aux (y::ys, prevMax) = 
            let val newMax = Int.max (prevMax, y)
            in newMax :: aux(ys, newMax)
            end
    in
      x :: aux(xs, x)
    end

(* reverse the prefix function to find the maximum to the right *)
fun suffixMax xs = List.rev (prefixMax (List.rev xs))

fun zip3 ([], [], []) = []
  | zip3 (x::xs, y::ys, z::zs) = (x,y,z)::zip3(xs, ys, zs)
  | zip3 _ = raise Fail "Mismatched lengths"

(* for each i find the max from the left *)
(* for each i find the max from the right *)
(* for each i find the amount of water that can be placed *)
fun rainAmount heights =
  let
    val leftMax  = prefixMax heights
    val rightMax = suffixMax heights
    val triples = zip3 (leftMax, rightMax, heights)
    fun water (l, r, h) = Int.max (0, Int.min(l, r) - h)
  in
    List.foldl (fn (triple, acc) => water triple + acc) 0 triples
  end

(* main function *)
(* read infile *)
(* calculate the total rain amount *)
fun rain(fileName : string) =
    let
        val infile = TextIO.openIn fileName
        val str1 = TextIO.inputLine infile
    in
        case str1 of
            NONE => TextIO.print "Error: Unable to read from the input file!\n"
        |   SOME s1 =>
            let
                val N = Int.fromString s1
                val str2 = TextIO.inputLine infile
            in
                case str2 of
                    NONE => TextIO.print "Error: Unable to read from the input file!\n"
                |   SOME s2 =>
                    let
                        val nums = map (
                            fn str =>
                                case Int.fromString str of
                                    NONE => 0
                                |   SOME n => n
                        ) (String.tokens (fn c => c = #" ") s2)
                        val result = rainAmount nums
                    in
                        TextIO.print (Int.toString result ^ "\n")
                    end
            end
    end

(* for this exercise we used chatgpt and stackoverflow *)
        