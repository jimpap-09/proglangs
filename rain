import sys  # Χρησιμοποιείται για να διαβάσουμε τα ορίσματα της εντολής (π.χ. όνομα αρχείου)

# Υπολογίζει το συνολικό νερό που μπορεί να αποθηκευτεί, με βέλτιστη χωρική πολυπλοκότητα
def rain_amount_optimized(heights):
    n = len(heights)
    left, right = 0, n - 1
    left_max, right_max = 0, 0
    total_water = 0

    while left <= right:
        if heights[left] < heights[right]:
            if heights[left] >= left_max:
                left_max = heights[left]
            else:
                total_water += left_max - heights[left]
            left += 1
        else:
            if heights[right] >= right_max:
                right_max = heights[right]
            else:
                total_water += right_max - heights[right]
            right -= 1

    return total_water

# Συνάρτηση για να διαβάσουμε τα δεδομένα από αρχείο και να υπολογίσουμε το αποτέλεσμα
def rain(filename):
    with open(filename, 'r') as file:
        n = int(file.readline())                    # Διαβάζουμε το πλήθος των θέσεων (το Ν)
        heights = list(map(int, file.readline().split()))  # Διαβάζουμε τα ύψη ως λίστα ακεραίων
        print(rain_amount_optimized(heights))       # Εκτυπώνουμε το αποτέλεσμα

# Κύριο πρόγραμμα που ελέγχει αν δόθηκε σωστά το όνομα αρχείου από το terminal
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 rain_optimized.py <input_file>")
    else:
        rain(sys.argv[1])

# Η χρονική πολυπλοκότητα είναι Ο(n)
# Η χωρική πολυπλοκότητα είναι O(1)
