require_relative 'pattern'

require_relative '../finite_automata/fa_rule'
require_relative '../finite_automata/nfa_rulebook'
require_relative '../finite_automata/nfa_design'

class Literal < Struct.new(:char)
    include Pattern

    def to_s
        self.char
    end

    def precedence
        3
    end

    def to_nfa_design
        start_state = Object.new
        accept_state = Object.new
        rule = FARule.new(start_state, self.char, accept_state)
        rulebook = NFARulebook.new([rule])

        NFADesign.new(start_state, [accept_state], rulebook)
    end
end
