class TagSystem < Struct.new(:crrnt_string, :rulebook)
    def run
        while self.rulebook.applies_to?(self.crrnt_string)
            puts self.crrnt_string
            self.step

            puts self.crrnt_string
        end
    end

    def step
        self.crrnt_string = self.rulebook.next_string(
            self.crrnt_string
        )
    end
end