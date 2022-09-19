class If < Struct.new(:cond, :conseq, :alter)
    def to_s
        "if (#{cond}) { #{conseq} } else { #{alter} }"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if cond.reducible?
            [If.new(cond.reduce(environment), conseq, alter), environment]
        else
            case cond
            when Boolean.new(true)
                [conseq, environment]
            when Boolean.new(false)
                [alter, environment]
            end
        end
    end
end
