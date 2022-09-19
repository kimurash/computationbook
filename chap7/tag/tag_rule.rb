class TagRule < Struct.new(:first_char, :append_chars)
    def applies_to?(string)
        string.chars.first == self.first_char
    end

    def follow(string)
        string + self.append_chars
    end
end
