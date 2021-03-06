textUtils = require '../src/text-utils'

describe 'text utilities', ->
  describe '.hasPairedCharacter(string)', ->
    it 'returns true when the string contains a surrogate pair, variation sequence, or combined character', ->
      expect(textUtils.hasPairedCharacter('abc')).toBe false
      expect(textUtils.hasPairedCharacter('a\uD835\uDF97b\uD835\uDF97c')).toBe true
      expect(textUtils.hasPairedCharacter('\uD835\uDF97')).toBe true
      expect(textUtils.hasPairedCharacter('\u2714\uFE0E')).toBe true
      expect(textUtils.hasPairedCharacter('e\u0301')).toBe true

      expect(textUtils.hasPairedCharacter('\uD835')).toBe false
      expect(textUtils.hasPairedCharacter('\uDF97')).toBe false
      expect(textUtils.hasPairedCharacter('\uFE0E')).toBe false
      expect(textUtils.hasPairedCharacter('\u0301')).toBe false

      expect(textUtils.hasPairedCharacter('\uFE0E\uFE0E')).toBe false
      expect(textUtils.hasPairedCharacter('\u0301\u0301')).toBe false

  describe '.isPairedCharacter(string, index)', ->
    it 'returns true when the index is the start of a high/low surrogate pair, variation sequence, or combined character', ->
      expect(textUtils.isPairedCharacter('a\uD835\uDF97b\uD835\uDF97c', 0)).toBe false
      expect(textUtils.isPairedCharacter('a\uD835\uDF97b\uD835\uDF97c', 1)).toBe true
      expect(textUtils.isPairedCharacter('a\uD835\uDF97b\uD835\uDF97c', 2)).toBe false
      expect(textUtils.isPairedCharacter('a\uD835\uDF97b\uD835\uDF97c', 3)).toBe false
      expect(textUtils.isPairedCharacter('a\uD835\uDF97b\uD835\uDF97c', 4)).toBe true
      expect(textUtils.isPairedCharacter('a\uD835\uDF97b\uD835\uDF97c', 5)).toBe false
      expect(textUtils.isPairedCharacter('a\uD835\uDF97b\uD835\uDF97c', 6)).toBe false

      expect(textUtils.isPairedCharacter('a\u2714\uFE0E', 0)).toBe false
      expect(textUtils.isPairedCharacter('a\u2714\uFE0E', 1)).toBe true
      expect(textUtils.isPairedCharacter('a\u2714\uFE0E', 2)).toBe false
      expect(textUtils.isPairedCharacter('a\u2714\uFE0E', 3)).toBe false

      expect(textUtils.isPairedCharacter('\uD835')).toBe false
      expect(textUtils.isPairedCharacter('\uDF97')).toBe false
      expect(textUtils.isPairedCharacter('\uFE0E')).toBe false
      expect(textUtils.isPairedCharacter('\uFE0E')).toBe false

      expect(textUtils.isPairedCharacter('\uFE0E\uFE0E')).toBe false

      expect(textUtils.isPairedCharacter('ae\u0301c', 0)).toBe false
      expect(textUtils.isPairedCharacter('ae\u0301c', 1)).toBe true
      expect(textUtils.isPairedCharacter('ae\u0301c', 2)).toBe false
      expect(textUtils.isPairedCharacter('ae\u0301c', 3)).toBe false
      expect(textUtils.isPairedCharacter('ae\u0301c', 4)).toBe false

  describe ".isDoubleWidthCharacter(character)", ->
    it "returns true when the character is either japanese, chinese or a full width form", ->
      expect(textUtils.isDoubleWidthCharacter("???")).toBe(true)

      expect(textUtils.isDoubleWidthCharacter("???")).toBe(true)

      expect(textUtils.isDoubleWidthCharacter("???")).toBe(true)
      expect(textUtils.isDoubleWidthCharacter("???")).toBe(true)
      expect(textUtils.isDoubleWidthCharacter("???")).toBe(true)

      expect(textUtils.isDoubleWidthCharacter("a")).toBe(false)

  describe ".isHalfWidthCharacter(character)", ->
    it "returns true when the character is an half width form", ->
      expect(textUtils.isHalfWidthCharacter("???")).toBe(true)
      expect(textUtils.isHalfWidthCharacter("???")).toBe(true)
      expect(textUtils.isHalfWidthCharacter("???")).toBe(true)
      expect(textUtils.isHalfWidthCharacter("???")).toBe(true)

      expect(textUtils.isHalfWidthCharacter("B")).toBe(false)

  describe ".isKoreanCharacter(character)", ->
    it "returns true when the character is a korean character", ->
      expect(textUtils.isKoreanCharacter("???")).toBe(true)
      expect(textUtils.isKoreanCharacter("???")).toBe(true)
      expect(textUtils.isKoreanCharacter("???")).toBe(true)
      expect(textUtils.isKoreanCharacter("???")).toBe(true)

      expect(textUtils.isKoreanCharacter("O")).toBe(false)

  describe ".isCJKCharacter(character)", ->
    it "returns true when the character is either a korean, half-width or double-width character", ->
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)
      expect(textUtils.isCJKCharacter("???")).toBe(true)

      expect(textUtils.isDoubleWidthCharacter("a")).toBe(false)
      expect(textUtils.isDoubleWidthCharacter("O")).toBe(false)
      expect(textUtils.isDoubleWidthCharacter("z")).toBe(false)
