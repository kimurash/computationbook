class DPDADesign < Struct.new(:start_state, :bottom_char,
                              :accept_states, :rulebook)
    def accepts?(string)
        self.to_dpda.tap {|dpda|
            dpda.read_string(string)
        }.accepting?
    end

    def to_dpda
        start_stack = Stack.new([self.bottom_char])
        start_config = PDAConfiguration.new(
            self.start_state, start_stack
        )
        DPDA.new(start_config, self.accept_states, self.rulebook)
    end
end