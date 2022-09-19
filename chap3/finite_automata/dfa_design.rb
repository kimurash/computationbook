require_relative 'dfa'

class DFADesign < Struct.new(:start_state, :accept_states, :rulebook)
    # to_dfaメソッドを使って新しいDFAを生成し,
    # read_string()を呼び出す
    def accepts?(string)
        # tapメソッドはブロックを評価し,
        # そのメソッドを呼び出したオブジェクトを返す(dfa)
        self.to_dfa.tap { |dfa|
            dfa.read_string(string)
        }.accepting?
    end

    def to_dfa
        DFA.new(self.start_state, self.accept_states, self.rulebook)
    end
end