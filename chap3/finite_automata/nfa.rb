class NFA < Struct.new(:crrnt_states, :accept_states, :rulebook)
    def accepting?
        # 現状態と受理集合の共通部分をとる
        (crrnt_states & accept_states).any?
    end

    def read_string(string)
        string.chars.each do |char|
            self.read_char(char)
        end
    end

    def read_char(char)
        self.crrnt_states = self.rulebook.next_states(self.crrnt_states, char)
    end

    # Structから継承したゲッタNFA#crrntsをオーバーライド
    def crrnt_states
        self.rulebook.follow_free_moves(super)
    end
end