function Tree(left, value, right) {
    this.left = left;
    this.value = value;
    this.right = right;
}

function* generator(tree) {
    if (tree.left != null) {
        yield* generator(tree.left);
    }

    yield tree.value;

    if (tree.right != null) {
        yield* generator(tree.right);
    }


}

var leafLeft = new Tree(null, 5, null);
var leafRight = new Tree(null, 6, null);
var node2 = new Tree(leafLeft, 2, leafRight);
var node1 = new Tree(node2, 1, null);


var it = generator(node1);

for (var i of it)
    console.log(i);

//console.log(node1);