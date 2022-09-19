class Not < Struct.new(:op)
    def to_s
        "~#{op}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if op.reducible?
            Add.new(op.reduce(environment))
        else
            Number.new(~op.value)
        end
    end
end
