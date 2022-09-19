class NPDA < Struct.new(:crrnt_configs, :accept_states, :rulebook)
    def accepting?
        # 現状態と受理集合の共通部分をとる
        self.crrnt_configs.any?{ |config|
            self.accept_states.include?(config.state)
        }
    end

    def read_string(string)
        string.chars.each do |char|
            self.read_char(char)
        end
    end

    def read_char(char)
        self.crrnt_configs = self.rulebook.next_configs(self.crrnt_configs, char)
    end

    # Structから継承したゲッタNFA#crrntsをオーバーライド
    def crrnt_configs
        self.rulebook.follow_free_moves(super)
    end
end