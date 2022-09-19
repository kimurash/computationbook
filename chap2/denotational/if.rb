require_relative "../syntax/if.rb"

class If
    def to_ruby
        "-> env { if (#{cond.to_ruby}).call(env) then" +
        "   (#{conseq.to_ruby}).call(env)" +
        "else" +
        "   (#{alter.to_ruby}).call(env)" +
        "end }"
    end
end
