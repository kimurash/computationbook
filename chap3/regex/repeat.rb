# パターンの繰り返し
require_relative 'pattern'

class Repeat < Struct.new(:pattern)
    include Pattern
    
    def to_s
        self.pattern.bracket(self.precedence) + '*'
    end

    def precedence
        2
    end

    def to_nfa_design
        pattern_nfa_design = self.pattern.to_nfa_design

        start_state = Object.new
        accept_states = pattern_nfa_design.accept_states + [start_state]
        rules = pattern_nfa_design.rulebook.rules
        extra_rules = 
            pattern_nfa_design.accept_states.map {|accept_state|
                # 元の受理状態 --> 元の開始状態
                FARule.new(accept_state, nil, pattern_nfa_design.start_state)
            } + 
            [FARule.new(start_state, nil, pattern_nfa_design.start_state)]
        rulebook = NFARulebook.new(rules + extra_rules)

        NFADesign.new(start_state, accept_states, rulebook)
    end
end
