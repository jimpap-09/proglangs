(* Ταξινόμηση κατά φθίνουσα σειρά *)
fun sortDescending cmp lst =
    let
        fun insert x [] = [x]
          | insert x (y::ys) =
                if cmp x y then x :: y :: ys
                else y :: insert x ys
        fun isort [] = []
          | isort (x::xs) = insert x (isort xs)
    in
        isort lst
    end

(* Κύρια συνάρτηση που υπολογίζει το μέγιστο κέρδος *)
fun maxProfit m workers =
    let
        (* Προσθέτουμε και τη διαφορά a - b *)
        val withDiff = map (fn (a, b) => (a, b, a - b)) workers
        (* Ταξινόμηση με βάση το a - b καθοδικά *)
        val sorted = sortDescending (fn (_, _, d1) => fn (_, _, d2) => d1 > d2) withDiff
        (* Παίρνουμε τους m πρώτους για συμβόλαιο A *)
        fun take 0 _ = []
          | take _ [] = []
          | take n (x::xs) = x :: take (n - 1) xs
        fun drop 0 xs = xs
          | drop _ [] = []
          | drop n (_::xs) = drop (n - 1) xs
        val contractA = take m sorted
        val contractB = drop m sorted
        val sumA = foldl (fn ((a, _, _), acc) => a + acc) 0 contractA
        val sumB = foldl (fn ((_, b, _), acc) => b + acc) 0 contractB
    in
        sumA + sumB
    end

(* Κύρια main function *)
fun hire(fileName : string) =
    let
        val infile = TextIO.openIn fileName
        val line1 = valOf (TextIO.inputLine infile)
        val [mStr, kStr] = String.tokens (fn c => c = #" ") line1
        val m = valOf (Int.fromString mStr)
        val _ = valOf (Int.fromString kStr)  (* Δεν χρησιμοποιείται *)

        fun loop acc =
            case TextIO.inputLine infile of
                NONE => List.rev acc
              | SOME line =>
                    let
                        val [aStr, bStr] = String.tokens (fn c => c = #" ") line
                        val a = valOf (Int.fromString aStr)
                        val b = valOf (Int.fromString bStr)
                    in
                        loop ((a, b) :: acc)
                    end

        val workers = loop []
        val result = maxProfit m workers
    in
        TextIO.print (Int.toString result ^ "\n")
    end