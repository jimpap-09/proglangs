(* minDiffSubArray *)
fun minDiffSubArray (a : int list, tot_sum : int) : int =
    (* calMinDiff, iterK *)
    let
        fun calMinDiff ([], _, minDiff) = minDiff
          | calMinDiff (x::xs, prefixSum, minDiff) =
                let
                    val newPrefixSum = prefixSum + x
                    val diff = abs((tot_sum - newPrefixSum) - newPrefixSum)
                    val newMinDiff = if diff < minDiff then diff else minDiff
                in
                    (* calculate minDiff for a given array *)
                    calMinDiff(xs, newPrefixSum, newMinDiff)
                end
        fun iterK (k : int, n : int, minDiff : int) =
            if k = n then minDiff
            else
                let
                    val droppedList = List.drop(a, k)
                    (* calculate minDiff for the droppedList *)
                    val newMinDiff = calMinDiff(droppedList, 0, minDiff)
                in
                    iterK(k+1, n, newMinDiff)
                end
    in
        iterK (0, length a, tot_sum)
    end

(* fairseq *)
fun fairseq(fileName : string) =
    let
        val inputFileName = TextIO.openIn fileName
        (* read first line *)
        val str1 = TextIO.inputLine inputFileName
    in
        case str1 of
            NONE => TextIO.print "Error: Unable to read from the input file!\n"
          | SOME s1 =>
            let
                val N = Int.fromString s1
                (* read second line *)
                val str2 = TextIO.inputLine inputFileName
            in
                case str2 of
                    NONE => TextIO.print "Error: Unable to read from the input file!\n"
                  | SOME s2 =>
                    let
                        val nums = map (fn str =>
                                        case Int.fromString str of
                                          NONE => 0
                                        | SOME n => n
                                    ) (String.tokens (fn c => c = #" ") s2)
                        val tot_sum = List.foldl (op +) 0 nums
                        val minDiff = minDiffSubArray (nums, tot_sum)
                    in
                        (* print minDiff *)
                        TextIO.print (Int.toString minDiff ^ "\n")
                    end
            end
    end