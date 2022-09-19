require 'set'

class NFARulebook < Struct.new(:rules)
    # 自由移動によって到達可能な全ての状態を見つける
    def follow_free_moves(states)
        more_states = self.next_states(states, nil)

        # next_statesで見つかった状態が既に含まれているか
        if more_states.subset?(states)
            states
        else
            follow_free_moves(states + more_states)
        end
    end

    # とり得る全ての状態を集合を見つける
    def next_states(states, char)
        states.flat_map{ |state|
            follow_rules_for(state, char)
        }.to_set
    end

    # 規則に従って遷移
    def follow_rules_for(state, char)
        self.rules_for(state, char).map(&:follow)
    end

    # 適用可能な規則を選択
    def rules_for(state, char)
        rules.select { |rule|
            rule.applies_to?(state, char)
        }
    end

    # 入力文字の一覧
    def alphabet
        self.rules.map(&:char).compact.uniq
    end
end
