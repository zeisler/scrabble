Array.prototype.last = (function(){
  return this.reverse()[0];
});
Array.prototype.first = (function(){
  return this[0];
});

to_array = function(obj){
  if(typeof obj === 'array'){
    return obj;
  } else {
    array = [];
    array.push(obj);
    return array;
  }
};

//+ Jonas Raoni Soares Silva
//@ http://jsfromhell.com/array/shuffle [v1.0]
shuffle = function(o){ //v1.0
    for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};
