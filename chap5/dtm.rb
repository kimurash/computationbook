class DTM < Struct.new(:crrnt_config, :accept_states, :rulebook)
    def accepting?()
        self.accept_states.include?(self.crrnt_config.state)
    end

    def run
        # 受理状態になるまで構成遷移し続ける
        self.step until (self.accepting? || self.stuck?)
    end

    def step
        self.crrnt_config = self.rulebook.next_config(crrnt_config)
    end

    def stuck?
        !self.accepting? &&
        !self.rulebook.applies_to?(self.crrnt_config)
    end
end