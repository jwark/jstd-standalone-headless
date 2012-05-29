MyOtherClass = function() {
	this.speed = 0;
};

MyOtherClass.prototype = {
	stop: function() {
		this.speed = 0;
	},
	ride: function() {
		this.speed = 1;
	},
	getSpeed: function() {
		return this.speed;
	}
}
