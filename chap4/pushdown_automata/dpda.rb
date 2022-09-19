class DPDA < Struct.new(:crrnt_config, :accept_states, :rulebook)
    # 現状態は受理状態か?
    def accepting?
        self.accept_states.include?(
            # [XXX]: Objectに対してstateを呼び出しても大丈夫なのか?
            self.crrnt_config.state
        )
    end

    def read_string(string)
        string.chars.each do |char|
            self.read_char(char) unless self.stuck?
        end
    end

    def stuck?
        self.crrnt_config.stuck?
    end

    def read_char(char)
        self.crrnt_config = self.next_config(char)
    end

    def next_config(char)
        if self.rulebook.applies_to?(self.crrnt_config, char)
            self.rulebook.next_config(self.crrnt_config, char)
        else # 適用する規則がない
            self.crrnt_config.stuck
        end
    end

    # Structから継承したゲッタをオーバーライド
    def crrnt_config
        self.rulebook.follow_free_moves(super)
    end
end