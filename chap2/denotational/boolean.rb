require_relative "../syntax/boolean.rb"

class Boolean
    def to_ruby
        "-> env { #{value.inspect} }"
    end
end