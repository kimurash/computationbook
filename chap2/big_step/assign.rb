require_relative "../syntax/assign.rb"

class Assign
    def evaluate(environment)
        environment.merge(
            { name => expression.evaluate(environment) }
        )
    end
end