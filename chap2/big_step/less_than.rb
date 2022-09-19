require_relative "../syntax/less_than.rb"

class LessThan
    def evaluate(environment)
        Boolean.new(
            left.evaluate(environment).value <
            right.evaluate(environment).value
        )
    end
end
