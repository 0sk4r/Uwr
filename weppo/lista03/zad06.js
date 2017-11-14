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

var fib1 = {
	[Symbol.iterator] : parmGenerator(5)
};

for( let i of fib1)
    console.log(i);

var fib2 = {
	[Symbol.iterator] : parmGenerator(10)
}

for( let i of fib2)
	console.log(i);