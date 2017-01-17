mocha = require 'mocha'

module.exports = (runner) ->
  Base = mocha.reporters.Base

  Base.call @, runner

  color = Base.color
  passes = 0
  failures = 0
  indent = 0

  preappends =
    ok: color 'bright pass', "#{Base.symbols.ok}"
    err: color 'bright fail', "#{Base.symbols.err}"

  runner.on 'suite', (suite) ->
    console.log '%s%s', ' '.repeat(indent), color('suite',  "#{suite.title}")
    indent += 1

  runner.on 'suite end', (suite) ->
    indent -= 1
    if indent is 1 then console.log ''

  runner.on 'pass', (test) ->
    passes += 1
    console.log '%s %s %s', ' '.repeat(indent), preappends.ok, test.title

  runner.on 'fail', (test, err) ->
    failures +=1
    console.log '%s %s %s', ' '.repeat(indent), preappends.err, test.title

  runner.on 'end', () ->
    process.exit failures
