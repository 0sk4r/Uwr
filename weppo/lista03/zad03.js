var a = [1,2,3,4];

function forEach(list, fun){
    for (let i of list) {
        fun(i);
    }
}

function map(list,fun){
    let tmp = [];
    for (let i of list){
        tmp.push(fun(i));
    }
    return tmp;
}

function filter(list, fun){
    let tmp = [];
    for (let i of list){
        if(fun(i)) {tmp.push(i);}
    }
    return tmp;
}
forEach( a, _ => { console.log( _ ); });
console.log(map( a, _ => _ * 2 ));
console.log(filter( a, _ => _ < 3 ));

