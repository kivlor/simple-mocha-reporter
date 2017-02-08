assert = require 'assert'
mocha = require 'mocha'
Base = mocha.reporters.Base

Simple = require '../src/reporter'

runner = {}
stdout = []
stdoutWrite = null
useColors = null

describe 'Simple Reporter', () ->
  beforeEach () ->
    stdout = []
    runner = {}

    stdoutWrite = process.stdout.write
    process.stdout.write = (string) -> stdout.push string

    useColors = Base.useColors
    Base.useColors = false

  describe 'on suite start', () ->
    it 'should print suite title', () ->
      suite =
        title: 'Suite Title'

      runner.on = (event, cb) ->
        if event is 'suite' then cb suite

      Simple.call { epilogue: () -> null }, runner
      
      process.stdout.write = stdoutWrite
      Base.useColors = useColors

      assert.equal stdout[0], "Suite Title\n"

  describe 'on test pass', () ->
    it 'should print test title with tick', () ->
      test =
        title: 'Test Title'
        duration: 1
        slow: () -> 1

      runner.on = (event, cb) ->
        if event is 'pass' then cb test

      Simple.call { epilogue: () -> null }, runner
      
      process.stdout.write = stdoutWrite
      Base.useColors = useColors

      assert.equal stdout[0], " #{Base.symbols.ok} Test Title\n"

  describe 'on test fail', () ->
    it 'should print test title with cross', () ->
      test =
        title: 'Test Title'

      runner.on = (event, cb) ->
        if event is 'fail' then cb test

      Simple.call { epilogue: () -> null }, runner
      
      process.stdout.write = stdoutWrite
      Base.useColors = useColors

      assert.equal stdout[0], " #{Base.symbols.err} Test Title\n"