class Sign < Struct.new(:name)
    NEGATIVE, ZERO, POSITIVE = [:negative, :zero, :positive].map { |name|
        self.new(name)
    }
    UNKNOWN = self.new(:unknown)

    def inspect
        "#<Sign #{name}>"
    end

    def +(other_sign)
        if self == other_sign || other_sign == ZERO
            self
        elsif self == ZERO
            other_sign
        else
            UNKNOWN
        end
    end

    def *(other_sign)
        if [self, other_sign].include?(ZERO)
            ZERO
        elsif [self, other_sign].include?(UNKNOWN)
            UNKNOWN
        elsif self == other_sign
            POSITIVE
        else
            NEGATIVE
        end
    end

    def <=(other_sign)
        self == other_sign || other_sign == UNKNOWN
    end
end
