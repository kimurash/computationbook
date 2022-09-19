class DFARulebook < Struct.new(:rules)
    # 次の状態を返す
    def next_state(state, char)
        self.rule_for(state, char).follow
    end

    # 適用すべき規則を特定
    # [WARN]: 適用できる規則が複数存在すると最初の規則が適用される
    def rule_for(state, char)
        # メソッドは暗黙のブロック引数をとることができる(p.10)
        rules.detect { |rule|
            rule.applies_to?(state, char)
        }
    end
end