require_relative "../syntax/less_than.rb"

class LessThan
    def to_ruby
        "-> env { (#{left.to_ruby}).call(env) < (#{right.to_ruby}).call(env) }"
    end
end
