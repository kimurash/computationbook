class While < Struct.new(:cond, :body)
    def to_s
        "while (#{cond}) { #{body} }"
    end

    def inspect
        "<<#{self}>>"
    end
end