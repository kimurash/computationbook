class NPDADesign < Struct.new(:start_state, :bottom_char,
                              :accept_states, :rulebook)
    def accepts?(string)
        self.to_npda.tap {|npda|
            npda.read_string(string)
        }.accepting?
    end

    def to_npda
        start_stack = Stack.new([self.bottom_char])
        start_config = PDAConfiguration.new(
            self.start_state, start_stack
        )
        NPDA.new(Set[start_config], self.accept_states, self.rulebook)
    end
end
