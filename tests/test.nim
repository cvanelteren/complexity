import ../src/entropy

echo "HELLO"

var x = @[4, 7, 9, 10, 6, 11, 3]
echo x

# echo seq_array(p, 2)
echo permutation_entropy(x, 3, normalize = false)
