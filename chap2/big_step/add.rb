require_relative "../syntax/add.rb"

class Add
    def evaluate(environment)
        Number.new(
            left.evaluate(environment).value +
            right.evaluate(environment).value
        )
    end
end
