require_relative 'tag_rule'
require_relative 'tag_rulebook'
require_relative 'tag_system'

# 数を2倍にする規則
=begin
rulebook = TagRulebook.new(2, [
    TagRule.new('a', 'cc'), 
    TagRule.new('b', 'dddd')
])

system = TagSystem.new('aabbbbbb', rulebook)
system.run
=end

# 数を半分にする規則
=begin
rulebook = TagRulebook.new(2, [
    TagRule.new('a', 'cc'), 
    TagRule.new('b', 'd')
])
system = TagSystem.new('aabbbbbbbbbbbb', rulebook)
system.run
=end

# 数をインクリメントする規則
=begin
rulebook = TagRulebook.new(2, [
    TagRule.new('a', 'ccdd'), 
    TagRule.new('b', 'dd')
])
system = TagSystem.new('aabbbb', rulebook)
system.run
=end

# タグシステムを組み合わせる
=begin
rulebook = TagRulebook.new(2, [
    TagRule.new('a', 'cc'), TagRule.new('b', 'dddd'), # 2倍
    TagRule.new('c', 'eeff'), TagRule.new('d', 'ff')  # インクリメント
])
system = TagSystem.new('aabbbb', rulebook)
system.run
=end

# 遇奇を判定する
rulebook = TagRulebook.new(2, [
    TagRule.new('a', 'cc'), TagRule.new('b', 'd'), # 入力を半分にする
    TagRule.new('c', 'eo'), # cc -> eo どちらかが最終結果となる
    TagRule.new('d', ''),
    TagRule.new('e', 'e') 
])
system = TagSystem.new('aabbbbbbbb', rulebook)
system.run

system = TagSystem.new('aabbbbbbbbbb', rulebook)
system.run

