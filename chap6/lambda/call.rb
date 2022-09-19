class Call < Struct.new(:left, :right)
    def to_s
        "#{self.left}[#{self.right}]"
    end

    def inspect
        self.to_s
    end

    def replace(name, replacement)
        Call.new(
            self.left.replace(name, replacement),
            self.right.replace(name, replacement)
        )
    end

    # Callクラスがcallable?でないとは何事w
    def callable?
        false
    end

    def reducible?
        self.left.reducible? | self.right.reducible? |
        self.left.callable?
    end

    def reduce
        if self.left.reducible?
            Call.new(self.left.reduce, self.right)
        elsif self.right.reducible?
            Call.new(self.left, self.right.reduce)
        else
            self.left.call(self.right)
        end
    end
end

