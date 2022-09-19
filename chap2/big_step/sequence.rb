require_relative "../syntax/sequence.rb"

class Sequence
    def evaluate(environment)
        second.evaluate(
            first.evaluate(environment)
        )
    end
end
