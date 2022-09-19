class DPDARulebook < Struct.new(:rules)
    def follow_free_moves(config)
        # epsilon遷移できるか?
        if self.applies_to?(config, nil)
            self.follow_free_moves(self.next_config(config, nil))
        else
            config
        end
    end

    def next_config(config, char)
        rule_for(config, char).follow(config)
    end

    # 適用できる規則はあるか?
    def applies_to?(config, char)
        !self.rule_for(config, char).nil?
    end

    # 適用できる規則を見つける
    def rule_for(config, char)
        self.rules.detect { |rule|
            rule.applies_to?(config, char)
        }
    end
end