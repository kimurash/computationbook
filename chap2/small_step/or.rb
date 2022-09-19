class Or < Struct.new(:left, :right)
    def to_s
        "#{left} | #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            Or.new(left.reduce(environment), right)
        elsif right.reducible?
            Or.new(left, right.reduce(environment))
        else
            Number.new(left.value | right.value)
        end
    end
end
