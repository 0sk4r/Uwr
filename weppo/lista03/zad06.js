function parmGenerator(max){
	return function () {
		var _state = 0;
		return {
			next : function() {
				return {
					value : _state,
					done : _state++ >= max
				}
			}
		}
	}
}

var foo1 = {
	[Symbol.iterator] : parmGenerator(5)
};

for( let i of foo1)
    console.log(i);

var foo2 = {
	[Symbol.iterator] : parmGenerator(10)
}

for( let i of foo2)
	console.log(i);