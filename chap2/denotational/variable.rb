require_relative "../syntax/variable.rb"

class Variable
    def to_ruby
        # [HELP]: <<:x>>を式展開(p.8)すると:xになる?
        "-> env { env[#{name.inspect}] }"
    end
end
