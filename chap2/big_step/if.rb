require_relative "../syntax/if.rb"

class If
    def evaluate(environment)
        case cond.evaluate(environment)
        when Boolean.new(true)
            conseq.evaluate(environment)
        when Boolean.new(false)
            alter.evaluate(environment)
        end
    end
end
