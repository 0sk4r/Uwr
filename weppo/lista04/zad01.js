function Tree(left, value, right) {
  this.left = left;
  this.value = value;
  this.right = right;
}

var leafLeft = new Tree(null, 5, null);
var leafRight = new Tree(null, 6, null);
var node2 = new Tree(leafLeft, 2, leafRight);
var node1 = new Tree(node2, 1, null);

console.log(node1);