/*
 * aQuery - lightweight version of jQuery 
 */

 //core functionality required to work
 //modules should go between core_start and core_end
'use strict';

export function aQuery(selector){
	function aQueryObject(selector){
		if(typeof selector === 'string'){
			this.elementList = document.querySelectorAll(selector);
		}
		else if(selector instanceof Element){
			this.elementList = [selector];
		}
		else{
			//assume elementList
			this.elementList = selector;
		}
		this.length = this.elementList.length >= 0 ? this.elementList.length : 1;
	}
	/*
	* General utility methods
	*/
	//callback - index, element
	aQueryObject.prototype.each = function(func){
		for (var i = 0; i < this.length; i++) {
			func.call(this.elementList[i], i, this.elementList[i]);
		}
	}

/*
* Event methods
*/

aQueryObject.prototype.on = function(eventName, selector, callback){
	//check if using delegation
	if(selector instanceof Function){
		//not using delegation
		var callbackFunc = function(e){ selector.call(e.target, e); };
	}
	else{
		//using delegation
		//based on: https://davidwalsh.name/event-delegate
		var callbackFunc = function(e){
			if(e.target && e.target.matches(selector)){
				callback.call(e.target, e);
			}
		};
	}
	//add event listers
	this.each(function(i, element){
		//element.addEventListener(eventName, function(e){callbackFunc.call(element, e);}, false);
		element.addEventListener(eventName, callbackFunc, false);
	});

};
	/*
	* Input validation
	*/
	if(typeof selector === 'string' || typeof selector === 'object'){
		return (new aQueryObject(selector));
	}
}




