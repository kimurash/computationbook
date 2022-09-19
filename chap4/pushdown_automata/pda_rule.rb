=begin
決定性については何も仮定していないため
NPDAのシミュレートにも使える
=end
class PDARule < Struct.new(:state, :char, :next_state,
                           :pop_char, :push_chars)
    # 本規則を適用できるか?
    def applies_to?(config, char)
        self.state == config.state &&        # 機械の現状態
        self.pop_char == config.stack.top && # スタックのトップにある文字
        self.char == char                    # 次の入力文字
    end

    def follow(config)
        PDAConfiguration.new(
            self.next_state,
            next_stack(config)
        )
    end

    def next_stack(config)
        popped_stack = config.stack.pop

        # push_charsはポップする順になっている前提
        # pushする文字をあらかじめ反転させておく
        self.push_chars.reverse.inject(popped_stack){ |stack, char|
            stack.push(char)
        }
    end

    
end