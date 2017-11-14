function fibParm(max) {
	return function fib() {
		var _state0 = 0;
		var _state1 = 1;
		var _n = 0;
		return {
			next : function() {
				_tmp = _state1 + _state0;
				_state0 = _state1;
				_state1 = _tmp;
				_n++;

				return {
					value : _tmp,
					done : _n >= max
				}
			}
		}
	}
}

function fibUnlimited() {
	var _state0 = 0;
	var _state1 = 1;
	return {
		next : function() {
			_tmp = _state1 + _state0;
			_state0 = _state1;
			_state1 = _tmp;
			return {
				value : _tmp ,
				done : false
			}
		}
	}
}

function* fibYield() {
	var _state0 = 0;
	var _state1 = 1;

	while(true) {
		var _tmp = _state0 + _state1;
		_state0 = _state1;
		_state1 = _tmp;
		yield _tmp;
	}
	
}


var fib1 = {
	[Symbol.iterator] : fibUnlimited
}

var fib2 = {
	[Symbol.iterator] : fibParm(10) 
}

for( let i of fib2)
console.log(i);

var gen = fibYield();

for( let i = 0; i < 9; i++ )
    console.log(gen.next().value);
    

function* take(it, top) {
    for( let i = 0; i<top; i++)
        yield it.next().value;
}

for( let num of take( fibUnlimited(), 10 ) ) {
	console.log(num);	
}