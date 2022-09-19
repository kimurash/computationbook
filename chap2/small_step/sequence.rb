class Sequence < Struct.new(:first, :second)
    def to_s
        "#{first}; #{second}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    # 1番目の文がdo-nothing文となるまで簡約を続けて
    # それから2番目の式を簡約する
    def reduce(environment)
        case first
        when DoNothing.new
            [second, environment]
        else
            # 1番目の式を簡約
            reduced_first, reduced_environment = first.reduce(environment)
            [Sequence.new(reduced_first, second), reduced_environment]
        end
    end
end
