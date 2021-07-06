import logmap, entropy, sequtils

var x = @[4, 7, 9, 10, 6, 11, 3]
echo x
# echo seq_array(p, 2)
echo entropy.permutation_entropy(x, 3, normalize = false)
