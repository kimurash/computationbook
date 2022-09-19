class Stack < Struct.new(:contents)
    def push(char)
        Stack.new([char] + self.contents)
    end

    def pop
        Stack.new(self.contents.drop(1))
    end

    def top
        self.contents.first
    end

    def inspect
        "#<Stack (#{top})#{self.contents.drop(1).join}>"
    end
end
