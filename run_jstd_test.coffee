#!/usr/local/bin/phantomjs

fs = require('fs')

# Script Begin
if phantom.args.length > 1
  console.log "Either supply no arg and the script will list out the tests from your jsTestDriver.conf, OR pass through a path to a test file OR pass through a path containing test files."
  console.log "USAGE: phantomjs [path/to/test(s)]"
  phantom.exit 1

address = 'jstd-headless.html'

listTests = (path) ->
  files = []
  if fs.exists(path) and fs.isFile(path)
    files.push(path)
  else if fs.isDirectory(path)
    fs.list(path).forEach (e) ->
      files = files.concat(listTests(path + "/" + e)) if e isnt "." and e isnt ".."
  files

loadScriptsFromFile = (confFile, section) ->
  scripts = []
  currentSection = null
  data = fs.read(confFile)
  data.split(/\n/).forEach ( line ) ->
    if /^load/.test(line)
      currentSection = "load"
    else if /^test/.test(line)
      currentSection = "test"
    else if currentSection == section
      scripts.push(line.match( /\s-\s(\S+)/ )[1] ) if /^\s-\s/.test( line )
  scripts

testScripts = []
if phantom.args.length == 0
  console.log 'loading tests from: jsTestDriver.conf'
  testScripts = loadScriptsFromFile('jsTestDriver.conf', 'test')
else
  testsPath = phantom.args[0]
  console.log 'loading tests from:', testsPath
  testScripts = listTests testsPath

baseScripts = loadScriptsFromFile('jsTestDriver.conf', 'load')

allScripts = baseScripts.concat(testScripts)
#console.log 'testScripts:\n', testScripts.join('\n')
#console.log 'baseScripts:\n', baseScripts.join('\n')
#console.log 'allScripts:\n', allScripts.join('\n')

page = new WebPage()

# Don't supress console output
page.onConsoleMessage = (msg) ->
  console.log msg

  # Terminate when the reporter singals that testing is over.
  # We cannot use a callback function for this (because page.evaluate is sandboxed),
  # so we have to *observe* the website.
  if msg == "ConsoleReporter finished: success" then phantom.exit 0
  if msg == "ConsoleReporter finished: fail" then phantom.exit 1

evaluate = (page, func) ->
  args = [].slice.call(arguments, 2)
  fn = "function() { return (" + func.toString() + ").apply(this, " + JSON.stringify(args) + ");}"
  page.evaluate fn

page.open address, (status) =>
  if status != "success"
    console.log "can't load the address!"
    phantom.exit 1

  evaluate page, ((allScripts) ->
    load_scripts(allScripts)
  ), allScripts

