jstd-standalone-headless
========================

Standalone Headless (PhantomJS) JsTestDriver runner


Allows you to run jsTestDriver tests from the command line without running a server or opening a browser

Prints a lot of interesting data into the console

Requires jstd.html to be in the same directory as jsTestDriver.conf

If you are not using an external assert library like hamcrest, you will need to include the Assert.js from jstestdriver source
This is in the support directory. Simply creating a link tag in jstd.html should be sufficient.

install PhantomJS
$ brew install phantomjs

run the tests (listed in jsTestDriver.conf)
$ phantomjs run_jstd_test.coffee jstd.html


Much code was copied from:
https://github.com/mobz/jstd-standalone
https://github.com/jcarver989/phantom-jasmine
