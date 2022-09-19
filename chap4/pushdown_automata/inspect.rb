require_relative 'dpda_design'
require_relative 'dpda_rulebook'
require_relative 'dpda'
require_relative 'npda_design'
require_relative 'npda_rulebook'
require_relative 'npda'
require_relative 'pda_config'
require_relative 'pda_rule'
require_relative 'stack'

# スタックの導入
=begin
stack = Stack.new(['a', 'b', 'c', 'd', 'e'])
puts stack.top
puts stack.pop.pop.top
puts stack.push('x').push('y').top
puts stack.push('x').push('y').pop.top
=end

# 構成とPDA規則の導入
=begin
rule = PDARule.new(1, '(', 2, '$', ['b', '$'])
config = PDAConfiguration.new(1, Stack.new(['$']))
puts rule.applies_to?(config, '(')
puts rule.follow(config)
=end

# DPDA規則集の導入
=begin
rulebook = DPDARulebook.new([
    PDARule.new(1, '(', 2, '$', ['b', '$']),
    PDARule.new(2, '(', 2, 'b', ['b', 'b']),
    PDARule.new(2, ')', 2, 'b', []),
    PDARule.new(2, nil, 1, '$', ['$'])
])
=end
=begin
config = rulebook.next_config(config, '(')
config = rulebook.next_config(config, '(')
config = rulebook.next_config(config, ')')
=end

# DPDAの導入
=begin
dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
puts dpda.accepting?

dpda.read_string('(()')
puts dpda.accepting?
puts dpda.crrnt_config
=end

# epsilon遷移をサポート
# config = PDAConfiguration.new(2, Stack.new(['$']))
# puts rulebook.follow_free_moves(config)

=begin
dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
dpda.read_string('(()(')
puts dpda.accepting?
puts dpda.crrnt_config

dpda.read_string('))()')
puts dpda.accepting?
puts dpda.crrnt_config
=end

# DPDAの設計の導入
=begin
dpda_design = DPDADesign.new(1, '$', [1], rulebook)
puts dpda_design.accepts?('(((((((((())))))))))')
puts dpda_design.accepts?('()(())((()))(()(()))')
puts dpda_design.accepts?('(()(()(()()(()()))()')
=end

# 行き詰まり状態になるとエラーを吐く
# puts dpda_design.accepts?('())')
# -> `next_config': undefined method `follow' for nil:NilClass (NoMethodError)

# 行き詰まり状態を解決
=begin
dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
dpda.read_string('())')
puts dpda.crrnt_config
puts dpda.accepting?
puts dpda.stuck?
=end

# 回文の認識
=begin
rulebook = DPDARulebook.new([
    PDARule.new(1, 'a', 1, '$', ['a', '$']),
    PDARule.new(1, 'a', 1, 'a', ['a', 'a']),
    PDARule.new(1, 'a', 1, 'b', ['a', 'b']),
    PDARule.new(1, 'b', 1, '$', ['b', '$']),
    PDARule.new(1, 'b', 1, 'a', ['b', 'a']),
    PDARule.new(1, 'b', 1, 'b', ['b', 'b']),
    PDARule.new(1, 'm', 2, '$', ['$']),
    PDARule.new(1, 'm', 2, 'a', ['a']),
    PDARule.new(1, 'm', 2, 'b', ['b']),
    PDARule.new(2, 'a', 2, 'a', []),
    PDARule.new(2, 'b', 2, 'b', []),
    PDARule.new(2, nil, 3, '$', ['$'])
])
dpda_design = DPDADesign.new(1, '$', [3], rulebook)
puts dpda_design.accepts?('abmba')
puts dpda_design.accepts?('babbamabbab')
puts dpda_design.accepts?('abmb')
puts dpda_design.accepts?('baambaa')
=end

# 自由移動の導入
rulebook = NPDARulebook.new([
    PDARule.new(1, 'a', 1, '$', ['a', '$']),
    PDARule.new(1, 'a', 1, 'a', ['a', 'a']),
    PDARule.new(1, 'a', 1, 'b', ['a', 'b']),
    PDARule.new(1, 'b', 1, '$', ['b', '$']),
    PDARule.new(1, 'b', 1, 'a', ['b', 'a']),
    PDARule.new(1, 'b', 1, 'b', ['b', 'b']),
    PDARule.new(1, nil, 2, '$', ['$']),
    PDARule.new(1, nil, 2, 'a', ['a']),
    PDARule.new(1, nil, 2, 'b', ['b']),
    PDARule.new(2, 'a', 2, 'a', []),
    PDARule.new(2, 'b', 2, 'b', []),
    PDARule.new(2, nil, 3, '$', ['$'])
])
=begin
config = PDAConfiguration.new(1, Stack.new(['$']))
npda = NPDA.new(Set[config], [3], rulebook)
puts npda.accepting?
puts npda.crrnt_configs

npda.read_string('abb')
puts npda.accepting?
puts npda.crrnt_configs

npda.read_char('a')
puts npda.accepting?
puts npda.crrnt_configs
=end

# NPDAの設計の導入
npda_design = NPDADesign.new(1, '$', [3], rulebook)
puts npda_design.accepts?('abba')
puts npda_design.accepts?('babbaabbab')
puts npda_design.accepts?('abb')
puts npda_design.accepts?('baabaa')
