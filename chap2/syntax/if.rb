class If < Struct.new(:cond, :conseq, :alter)
    def to_s
        "if (#{cond}) { #{conseq} } else { #{alter} }"
    end

    def inspect
        "<<#{self}>>"
    end
end
