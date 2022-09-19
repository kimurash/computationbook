class DTMRulebook < Struct.new(:rules)
    # 適用できる規則はあるか?
    def applies_to?(config)
        !self.rule_for(config).nil?
    end

    def next_config(config)
        # [XXX]: 適用できる規則がなかったとき
        self.rule_for(config).follow(config)
    end
    
    # 適用できる規則を特定
    def rule_for(config)
        self.rules.detect{ |rule|
            rule.applies_to?(config)
        }
    end
end