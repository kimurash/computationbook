require_relative '../tag/tag_rule'

class CyclicTagRule < TagRule
    FIRST_CHAR = '1'

    # コンストラクタ
    def initialize(append_chars)
        super(FIRST_CHAR, append_chars)
    end

    def inspect
        "#<CyclicTagRule #{self.append_chars.inspect}>"
    end
end
