fun powerset_f [] = [[]]
  | powerset_f (h::t) = foldl (fn (x,acc) => x::(h::x)::acc) [] (powerset_f t)

fun powerset_m [] = [[]]
  | powerset_m (h::t) =
      let
	val pt = powerset_m t
      in 
	 pt @ (map (fn x => h::x) pt)
      end

fun comp ([],_) = false
  | comp (_,[]) = true
  | comp ((h1::t1), (h2::t2)) = if h1 = h2 then comp (t1,t2) else h1 > h2
 
fun assert msg cond = if cond then () else print ("wrong test: " ^ msg ^ "\n")

fun test_f f = (
  assert "zero"  (ListMergeSort.sort comp (f []) = [[]]);
  assert "one"   (ListMergeSort.sort comp (f [1]) = [[],[1]]);
  assert "two"   (ListMergeSort.sort comp (f [1,2]) = [[],[1],[1,2],[2]]);
  assert "three" (ListMergeSort.sort comp (f [1,2,3]) = [[],[1],[1,2],[1,2,3],[1,3],[2],[2,3],[3]])
)

val test = (test_f powerset_f; test_f powerset_m)