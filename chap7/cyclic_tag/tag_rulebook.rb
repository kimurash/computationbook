require_relative '../tag/tag_rulebook'

require_relative 'cyclic_tag_rule'
require_relative 'cyclic_tag_rulebook'

class TagRulebook
    # 規則集で使われている文字の集合
    def alphabet
        self.rules.flat_map(&:alphabet).uniq
    end

    # 適切な順序で規則を変換して返す
    def to_cyclic_rules(encoder)
        encoder.alphabet.map{ |char|
            self.cyclic_rule_for(char, encoder)
        }
    end

    def cyclic_rule_for(char, encoder)
        # 先頭の文字がcharの規則を特定
        rule = self.rule_for(char)

        # TagSystem#alphabetには含まれているが
        # TagRule#first_charには含まれていない文字
        if rule.nil?
            CyclicTagRule.new('')
        else
            rule.to_cyclic(encoder)
        end
    end

    # 削除数をシミュレートするための空白の規則
    def cyclic_padding_rules(encoder)
        Array.new(
            encoder.alphabet.length,
            CyclicTagRule.new('')
        ) * (self.del_num - 1)
        # 1引いているのは変換した規則によって削除される分
    end

    def to_cyclic(encoder)
        CyclicTagRulebook.new(
            self.to_cyclic_rules(encoder) +
            self.cyclic_padding_rules(encoder)
        )
    end
end
