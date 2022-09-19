class SKICall < Struct.new(:left, :right)
    def to_s
        "#{self.left}[#{self.right}]"
    end

    def inspect
        self.to_s
    end

    def combinator
        self.left.combinator
    end

    def arguments
        self.left.arguments + [right]
    end

    def reducible?
        self.left.reducible? || self.right.reducible? ||
        self.combinator.callable?(*self.arguments)
    end

    def reduce
        if self.left.reducible?
            SKICall.new(self.left.reduce, self.right)
        elsif self.right.reducible?
            SKICall.new(self.left, self.right.reduce)
        else
            self.combinator.call(*self.arguments)
        end
    end

    def as_function_of(name)
        left_func = self.left.as_function_of(name)
        right_func = self.right.as_function_of(name)
        
        SKICall.new(
            SKICall.new(S, left_func),
            right_func
        )
    end

    def to_iota
        SKICall.new(self.left.to_iota, self.right.to_iota)
    end
end
