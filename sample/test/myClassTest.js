TestCase("MyClass", {
	"test that walk() produces positive speed": function() {
		var p = new MyClass();
		p.walk();

		assertThat( p.getSpeed(), greaterThan( 0 ) );
	},
	"test that stop() produces 0 speed": function() {
		var p = new MyClass();
		p.walk();
		p.stop();

		assertThat( p.getSpeed(), equalTo( 2 ) );
	}
});
