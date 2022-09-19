require_relative "../syntax/mult.rb"

class Mult
    def evaluate(environment)
        Number.new(
            left.evaluate(environment).value *
            right.evaluate(environment).value
        )
    end
end
