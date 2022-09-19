require_relative "../syntax/assign.rb"

class Assign
    def to_ruby
        "-> env { env.merge({ #{name.inspect} => (#{expression.to_ruby}).call(env) }) }"
    end
end
