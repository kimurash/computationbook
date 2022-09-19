require_relative "../syntax/mult.rb"

class Mult
    def to_ruby
        "-> env { (#{left.to_ruby}).call(env) * (#{right.to_ruby}).call(env) }"
    end
end
