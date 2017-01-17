assert = require 'assert'

describe 'Foo', () ->
  describe 'given a passing assertion', () ->
    it 'should pass with a green message', () ->
      assert yes

  describe 'given a failing assertion', () ->
    it 'should fail with a red message', () ->
      assert no

describe 'Bar', () ->
  describe 'given a passing assertion', () ->
    it 'should pass with a green message', () ->
      assert yes

  describe 'given a failing assertion', () ->
    it 'should fail with a red message', () ->
      assert no
