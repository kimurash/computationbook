class DFA < Struct.new(:crrnt_state, :accept_states, :rulebook)
    def accepting?
        self.accept_states.include?(self.crrnt_state)
    end

    def read_string(string)
        string.chars.each do |char|
            self.read_char(char)
        end
    end

    def read_char(char)
        self.crrnt_state = self.rulebook.next_state(self.crrnt_state, char)
    end
end
