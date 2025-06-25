package boxes;

import java.io.*;
import java.util.*;

public class Boxes {
    public static void main(String[] args) throws IOException {
        try (Scanner scanner = new Scanner(new File(args[0]))) {
            int N = scanner.nextInt();      // πλήθος ειδών κουτιών
            int M = scanner.nextInt();      // μέγιστο άθροισμα (χώρος)
            int[] sizes = new int[N];

            for (int i = 0; i < N; i++) {
                sizes[i] = scanner.nextInt();
            }

            // DP πίνακας: κάθε θέση i περιέχει λίστα με όλους τους συνδυασμούς που δίνουν άθροισμα i
            List<List<List<Integer>>> dp = new ArrayList<>(M + 1);
            for (int i = 0; i <= M; i++) {
                dp.add(new ArrayList<>());
            }
            dp.get(0).add(new ArrayList<>()); // βάση: ένας τρόπος να φτάσεις το 0

            for (int size : sizes) {
                for (int i = 0; i <= M - size; i++) {
                    for (List<Integer> combination : dp.get(i)) {
                        List<Integer> newCombo = new ArrayList<>(combination);
                        newCombo.add(size);
                        dp.get(i + size).add(newCombo);
                    }
                }
            }

            // Αφαίρεση διπλοτύπων (π.χ. [2,2,4] και [4,2,2] θεωρούνται ίδια)
            Set<List<Integer>> uniqueSolutions = new HashSet<>();
            for (List<Integer> combo : dp.get(M)) {
                List<Integer> sorted = new ArrayList<>(combo);
                Collections.sort(sorted);
                uniqueSolutions.add(sorted);
            }

            if (uniqueSolutions.isEmpty()) {
                System.out.println("IMPOSSIBLE");
            } else {
                // Μετατροπή σε λίστα για ταξινόμηση
                List<List<Integer>> sortedSolutions = new ArrayList<>(uniqueSolutions);

                // Ταξινόμηση λεξικογραφικά με βάση τα στοιχεία
                sortedSolutions.sort((a, b) -> {
                    int minLen = Math.min(a.size(), b.size());
                    for (int i = 0; i < minLen; i++) {
                        int cmp = Integer.compare(a.get(i), b.get(i));  // Σωστή μέθοδος σύγκρισης
                        if (cmp != 0) return cmp;
                    }
                    // Αν όλα τα πρώτα στοιχεία είναι ίδια, μικρότερο μέγεθος προηγείται
                    return Integer.compare(a.size(), b.size());
                });

                for (List<Integer> solution : sortedSolutions) {
                    for (int x : solution) {
                        System.out.print(x + " ");
                    }
                    System.out.println();
                }
            }
        }
    }
}