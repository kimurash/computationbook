# 通常のタグシステムとは挙動が異なるためスクラッチから実装

class CyclicTagRulebook < Struct.new(:rules)
    DEL_NUM = 1

    # コンストラクタ
    def initialize(rules)
        # 規則集は要素を永久に循環するEnumeraterとして実装
        super(rules.cycle)
    end

    def applies_to?(string)
        # 空でない限りrulebookは適用される
        string.length >= DEL_NUM
    end

    def next_string(string)
        self.follow_next_rule(string).slice(DEL_NUM..-1)
    end

    def follow_next_rule(string)
        rule = rules.next

        if rule.applies_to?(string)
            rule.follow(string)
        else
            string
        end
    end
end