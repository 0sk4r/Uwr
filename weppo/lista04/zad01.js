function Tree(left, value, right) {
  this.left = left;
  this.value = value;
  this.right = value;
}

var leafLeft = Tree(null, 5, null);
var leafRight = Tree(null, 6, null);
var node = Tree(leafLeft, 1, leafRight);

console.log("LOl");