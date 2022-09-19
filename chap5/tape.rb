class Tape < Struct.new(:left, :middle, :right, :blank)
    def write(char)
        Tape.new(self.left, char, self.right, self.blank)
    end

    def move_head_left
        Tape.new(self.left[0..-2],
            self.left.last || self.blank,
            [self.middle] + self.right,
            self.blank
        )
    end

    def move_head_right
        Tape.new(
            self.left + [self.middle],
            self.right.first || self.blank,
            self.right.drop(1),
            self.blank
        )
    end

    def inspect
        "<Tape #{self.left.join}(#{self.middle})#{self.right.join}>"
    end
end
