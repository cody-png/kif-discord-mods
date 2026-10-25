#==============================================================================
# Kanto Reloaded Legacy - Safe JSON
#==============================================================================
# Legacy's own strict JSON reader and writer. The game's ::JSON (PIF's
# 001_Technical/002_Files/003_HTTP_Utilities.rb) reads with eval, so it ran a
# file's text as Ruby code (an imported catalog could run anything), turned
# "key": into symbols (the version read as 0.0.0) and failed on null; its
# writer doesn't escape quotes or backslashes. Platform reads and writes JSON
# through this module only.
#==============================================================================

module KantoReloaded
  module SafeJSON
    ESCAPES = {
      '"' => '\\"', "\\" => "\\\\", "\n" => "\\n", "\r" => "\\r",
      "\t" => "\\t", "\b" => "\\b", "\f" => "\\f"
    }.freeze
    UNESCAPES = {
      '"' => '"', "\\" => "\\", "/" => "/", "b" => "\b", "f" => "\f",
      "n" => "\n", "r" => "\r", "t" => "\t"
    }.freeze
    LITERAL = /\A(?:true|false|null|-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?)/.freeze

    class ParseError < StandardError; end

    module_function

    # Hashes come back with String keys; raises ParseError on bad JSON
    def parse(text)
      source = text.to_s.dup.force_encoding("UTF-8")
      raise ParseError, "The JSON isn't valid UTF-8." unless source.valid_encoding?
      Reader.new(source.sub(/\A﻿/, "")).read
    end

    def generate(value)
      case value
      when Hash
        "{" + value.map { |key, entry| "#{quote(key.to_s)}:#{generate(entry)}" }.join(",") + "}"
      when Array
        "[" + value.map { |entry| generate(entry) }.join(",") + "]"
      when String then quote(value)
      when Symbol then quote(value.to_s)
      when true then "true"
      when false then "false"
      when nil then "null"
      when Integer then value.to_s
      when Float then value.finite? ? value.to_s : "null"
      else quote(value.to_s)
      end
    end

    def quote(text)
      body = text.to_s.dup.force_encoding("UTF-8").gsub(/["\\\x00-\x1f]/) do |char|
        ESCAPES[char] || format("\\u%04x", char.ord)
      end
      "\"#{body}\""
    end

    class Reader
      def initialize(text)
        @chars = text.chars
        @index = 0
      end

      def read
        result = value
        skip
        fail_at("Unexpected text after the JSON") if @index < @chars.length
        result
      end

      private

      def skip
        @index += 1 while @index < @chars.length && " \t\r\n".include?(@chars[@index])
      end

      def value
        skip
        case @chars[@index]
        when "{" then object
        when "[" then array
        when '"' then string
        when nil then fail_at("The JSON ended early")
        else literal
        end
      end

      def object
        @index += 1
        result = {}
        skip
        if @chars[@index] == "}"
          @index += 1
          return result
        end
        loop do
          skip
          fail_at("Expected a key") unless @chars[@index] == '"'
          key = string
          skip
          fail_at("Expected :") unless @chars[@index] == ":"
          @index += 1
          result[key] = value
          skip
          case @chars[@index]
          when "," then @index += 1
          when "}"
            @index += 1
            return result
          else fail_at("Expected , or }")
          end
        end
      end

      def array
        @index += 1
        result = []
        skip
        if @chars[@index] == "]"
          @index += 1
          return result
        end
        loop do
          result << value
          skip
          case @chars[@index]
          when "," then @index += 1
          when "]"
            @index += 1
            return result
          else fail_at("Expected , or ]")
          end
        end
      end

      def string
        @index += 1
        out = +""
        loop do
          char = @chars[@index]
          fail_at("A text value isn't closed") if char.nil?
          @index += 1
          return out if char == '"'
          if char == "\\"
            code = @chars[@index]
            @index += 1
            if code == "u"
              out << [unicode].pack("U")
            elsif UNESCAPES.key?(code)
              out << UNESCAPES[code]
            else
              fail_at("Unknown escape \\#{code}")
            end
          else
            out << char
          end
        end
      end

      def unicode
        point = hex4
        if point.between?(0xD800, 0xDBFF) && @chars[@index] == "\\" && @chars[@index + 1] == "u"
          saved = @index
          @index += 2
          low = hex4
          return 0x10000 + ((point - 0xD800) << 10) + (low - 0xDC00) if low.between?(0xDC00, 0xDFFF)
          @index = saved
        end
        point
      end

      def hex4
        digits = @chars[@index, 4].to_a.join
        fail_at("Bad \\u escape") unless digits =~ /\A[0-9a-fA-F]{4}\z/
        @index += 4
        digits.to_i(16)
      end

      def literal
        text = @chars[@index, 64].to_a.join[LITERAL]
        fail_at("Unexpected #{@chars[@index].inspect}") unless text
        @index += text.length
        case text
        when "true" then true
        when "false" then false
        when "null" then nil
        else text =~ /[.eE]/ ? text.to_f : text.to_i
        end
      end

      def fail_at(message)
        raise ParseError, "#{message} (character #{@index + 1})"
      end
    end
  end
end
