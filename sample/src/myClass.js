MyClass = function() {
	this.speed = 0;
};

MyClass.prototype = {
	stop: function() {
		this.speed = 0;
	},
	walk: function() {
		this.speed = 1;
	},	
	getSpeed: function() {
		return this.speed;
	}
}