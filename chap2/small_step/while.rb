class While < Struct.new(:cond, :body)
    def to_s
        "while (#{cond}) { #{body} }"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

=begin
    while (cond){ body }
    --> if (cond){ body while(cond){ body } }
        else { do^nothing }
=end
    def reduce(environment)
        [If.new(cond, Sequence.new(body, self), DoNothing.new),
            environment]
    end
end