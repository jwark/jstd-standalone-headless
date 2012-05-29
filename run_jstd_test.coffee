#!/usr/local/bin/phantomjs

# Script Begin
if phantom.args.length == 0
  console.log "Need a url as the argument"
  phantom.exit 1

page = new WebPage()

# Don't supress console output
page.onConsoleMessage = (msg) ->
  console.log msg

  # Terminate when the reporter singals that testing is over.
  # We cannot use a callback function for this (because page.evaluate is sandboxed),
  # so we have to *observe* the website.
  if msg == "ConsoleReporter finished: success" then phantom.exit 0
  if msg == "ConsoleReporter finished: fail" then phantom.exit 1

address = phantom.args[0]
page.open address, (status) ->
  if status != "success"
    console.log "can't load the address!"
    phantom.exit 1
