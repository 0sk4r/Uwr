function parmFib(max) {
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

function fib() {
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

function *fibYield() {
	var _state0 = 0;
	var _state1 = 1;

	while(true) {
		var _tmp = _state0 + _state1;
		_state0 = _state1;
		_state1 = _tmp;
		yield _tmp;
	}
	
}


var foo = {
	[Symbol.iterator] : fib
}

var foo2 = {
	[Symbol.iterator] : parmFib(15) 
}

for( let i of foo2)
console.log(i);

var gen = fibYield();

for( let i = 0; i < 14; i++ )
    console.log(gen.next().value);
    

function* take(it, top) {
    for( let i = 0; i<top; i++)
        yield it.next().value;
}

for( let num of take( fib(), 10 ) ) {
	console.log(num);	
}