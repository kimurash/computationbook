
# シミュレーション状態 := NFA状態の集合
class NFASimulation < Struct.new(:nfa_design)
    def to_dfa_design
        start_state = Set[self.nfa_design.start_state]
        states, rules = self.discover_states_and_rules(Set[start_state])
        accept_states = states.select { |state|
            self.nfa_design.to_nfa(state).accepting?
        }
    
        DFADesign.new(start_state, accept_states, DFARulebook.new(rules))
    end

    # - rules_for()メソッドを再帰的に呼び出すことで
    #   取り得る全ての状態を調べる
    # - statesはNFA状態の集合の集合
    def discover_states_and_rules(states)
        # flat_map()はmapとflattenを一括で実行する
        # flattenは多次元配列を1次元配列にする
        rules = states.flat_map { |state|
            self.rules_for(state)
        }
        # 新しいシミュレーション状態を見つける
        more_states = rules.map(&:follow).to_set

        if more_states.subset?(states)
            [states, rules]
        else
            self.discover_states_and_rules(states + more_states)
        end
    end

    # 特定のシミュレーション状態における全ての規則を列挙する
    def rules_for(state)
        self.nfa_design.rulebook.alphabet.map { |char|
            FARule.new(state, char, self.next_state(state, char))
        }
    end


    # 引数のstateは状態の集合
    def next_state(state, char)
        self.nfa_design.to_nfa(state).tap { |nfa|
            nfa.read_char(char)
        }.crrnt_states
    end
end
