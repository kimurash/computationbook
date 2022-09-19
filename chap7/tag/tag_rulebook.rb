class TagRulebook < Struct.new(:del_num, :rules)
    def applies_to?(string)
        !self.rule_for(string).nil? && string.length >= self.del_num
    end

    def next_string(string)
        self.rule_for(string)
            .follow(string)
            .slice(self.del_num .. -1)
    end

    def rule_for(string)
        self.rules.detect{ |rule|
            rule.applies_to?(string)
        }
    end
end