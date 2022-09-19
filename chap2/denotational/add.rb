require_relative "../syntax/add.rb"

class Add
    def to_ruby
        "-> env { (#{left.to_ruby}).call(env) + (#{right.to_ruby}).call(env) }"
    end
end
