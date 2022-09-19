require_relative 'nfa'

class NFADesign < Struct.new(:start_state, :accept_states, :rulebook)
    def accepts?(string)
        self.to_nfa.tap { |nfa|
                nfa.read_string(string)
        }.accepting?
    end

    # 任意の状態から開始できるように引数オプションを追加
    def to_nfa(crrnt_states = Set[start_state])
        NFA.new(crrnt_states, self.accept_states, self.rulebook)
    end
end
