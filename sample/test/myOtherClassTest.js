TestCase("MyOtherClass", {
	"test that ride() produces positive speed": function() {
		var p = new MyOtherClass();
		p.ride();

		assertThat( p.getSpeed(), greaterThan( 0 ) );
	},
	"test that stop() produces 0 speed": function() {
		var p = new MyOtherClass();
		p.ride();
		p.stop();

		assertThat( p.getSpeed(), equalTo( 0 ) );
	}
});
