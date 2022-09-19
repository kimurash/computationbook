# パターンの連結
require_relative 'pattern'

require_relative '../finite_automata/fa_rule'
require_relative '../finite_automata/nfa_design'
require_relative '../finite_automata/nfa_rulebook'

class Concatenate < Struct.new(:first, :second)
    include Pattern

    def to_s
        [self.first, self.second].map { |pattern|
            pattern.bracket(self.precedence)
        }.join
    end

    def precedence
        1
    end

    def to_nfa_design
        first_nfa_design = self.first.to_nfa_design
        second_nfa_design = self.second.to_nfa_design

        start_state = first_nfa_design.start_state
        accept_states = second_nfa_design.accept_states
        rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
        extra_rules = first_nfa_design.accept_states.map { |state|
            FARule.new(state, nil, second_nfa_design.start_state)
        }
        rulebook = NFARulebook.new(rules + extra_rules)

        NFADesign.new(start_state, accept_states, rulebook)
    end
end