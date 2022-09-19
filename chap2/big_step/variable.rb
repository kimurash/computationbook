require_relative "../syntax/variable.rb"

class Variable
    def evaluate(environment)
        environment[name]
    end
end
