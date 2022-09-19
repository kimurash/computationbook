class Sub < Struct.new(:left, :right)
    def to_s
        "#{left} - #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            Sub.new(left.reduce(environment), right)
        elsif right.reducible?
            Sub.new(left, right.reduce(environment))
        else
            Number.new(left.value - right.value)
        end
    end
end
