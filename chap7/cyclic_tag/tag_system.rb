require_relative '../tag/tag_system'
require_relative 'cyclic_tag_encoder'

class TagSystem
    # タグシステムで使われている文字の集合
    def alphabet
        (
            self.rulebook.alphabet +
            self.crrnt_string.chars.entries
        ).uniq.sort
    end

    def get_encoder
        @encoder = CyclicTagEncoder.new(self.alphabet)
    end

    def to_cyclic
        TagSystem.new(
            @encoder.encode_string(self.crrnt_string),
            self.rulebook.to_cyclic(@encoder)
        )
    end
end
