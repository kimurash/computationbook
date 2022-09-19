require_relative 'cyclic_tag_encoder'
require_relative 'cyclic_tag_rule'
require_relative 'cyclic_tag_rulebook'

require_relative 'tag_rule'
require_relative 'tag_rulebook'
require_relative 'tag_system'

# require_relative '../tag/tag_system'

# 循環タグシステムの実装
=begin
rulebook = CyclicTagRulebook.new([
    CyclicTagRule.new('1'),
    CyclicTagRule.new('0010'),
    CyclicTagRule.new('10')
])
system = TagSystem.new('11', rulebook)

16.times do
    puts system.crrnt_string
    system.step
end
# puts system.crrnt_string

20.times do
    puts system.crrnt_string
    system.step
end
puts system.crrnt_string
=end

# タグシステムのアルファベットの把握
rulebook = TagRulebook.new(2, [
    TagRule.new('a', 'ccdd'),
    TagRule.new('b', 'dd')
])
system = TagSystem.new('aabbbb', rulebook)
puts system.alphabet.inspect

# エンコーダの実装
encoder = system.get_encoder
# puts encoder.encode_char('c').inspect
# puts encoder.encode_string('cab').inspect

# 規則のエンコード
# rule = system.rulebook.rules.first
# puts rule.to_cyclic(encoder)

# 規則集のエンコード
cyclic_rules =  system.rulebook.to_cyclic_rules(encoder)

# 削除数をシミュレートするための空白の規則
padding_rules = system.rulebook
                .cyclic_padding_rules(encoder)

cyclic_system = system.to_cyclic
cyclic_system.run

