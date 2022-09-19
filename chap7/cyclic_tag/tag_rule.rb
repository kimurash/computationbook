require_relative '../tag/tag_rule'
require_relative 'cyclic_tag_rule'

class TagRule
    # 規則で使われている文字の集合
    def alphabet
        (
            [self.first_char] + 
            self.append_chars.chars.entries
        ).uniq
    end

    def to_cyclic(encoder)
        CyclicTagRule.new(
            encoder.encode_string(self.append_chars)
            # 先頭の文字は規則の順番に反映される
        )
    end
end
