require_relative 'sign'

class Numeric
    def sign
        if self < 0
            Sign::NEGATIVE
        elsif self.zero?
            Sign::ZERO
        else
            Sign::POSITIVE
        end
    end
end