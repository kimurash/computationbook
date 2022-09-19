class FARule < Struct.new(:crrnt_state, :char, :next_state)
    # 当インスタンスの規則を適用できるか
    def applies_to?(state, char)
        self.crrnt_state == state && self.char == char
    end

    # 適用後の状態
    def follow
        next_state
    end

    def inspect
        "<FARule #{self.crrnt_state.inspect} --#{self.char.inspect}--> #{self.next_state.inspect}>"
    end
end
