require_relative 'dfa_design'
require_relative 'dfa_rulebook'
require_relative 'dfa'
require_relative 'fa_rule'
require_relative 'nfa_design'
require_relative 'nfa_rulebook'
require_relative 'nfa_sim'
require_relative 'nfa'

# 状態遷移表(rulebook)の導入
=begin
rulebook = DFARulebook.new([
    FARule.new(1, 'a', 2),
    FARule.new(1, 'b', 1),
    FARule.new(2, 'a', 2),
    FARule.new(2, 'b', 3),
    FARule.new(3, 'a', 3),
    FARule.new(1, 'b', 2),
])

puts rulebook.next_state(1, 'a')
puts rulebook.next_state(1, 'b')
puts rulebook.next_state(2, 'b')
=end

# DFAの導入
=begin
puts DFA.new(1, [1, 3], rulebook).accepting?
puts DFA.new(1, [3], rulebook).accepting?
=end

# 状態遷移の導入
=begin
dfa = DFA.new(1, [3], rulebook);
puts dfa.accepting?

dfa.read_char('b')
puts dfa.accepting?

3.times do dfa.read_char('a') end
puts dfa.accepting?

dfa.read_char('b')
puts dfa.accepting?

dfa.read_string("baab")
puts dfa.accepting?
=end

# DFAの設計の導入
=begin
dfa_design = DFADesign.new(1, [3], rulebook)
puts dfa_design.accepts?('a')
puts dfa_design.accepts?('baa')
puts dfa_design.accepts?('baba')
=end

# 規則集に非決定性を許容
=begin
rulebook = NFARulebook.new([
    FARule.new(1, 'a', 1), FARule.new(1, 'b', 1), FARule.new(1, 'b', 2),
    FARule.new(2, 'a', 3), FARule.new(2, 'b', 3),
    FARule.new(3, 'b', 4)
])
=end

=begin
puts rulebook.next_states(Set[1], 'b')
puts rulebook.next_states(Set[1, 2], 'a')
puts rulebook.next_states(Set[1, 3], 'b')
=end

# NFAの導入
=begin
nfa = NFA.new(Set[1], [4], rulebook)
puts nfa.accepting?

nfa.read_string('bab')
puts nfa.accepting?

nfa = NFA.new(Set[1], [4], rulebook)
nfa.read_string('bbbbb')
puts nfa.accepting?
=end

# NFAの設計の導入
=begin
nfa_design = NFADesign.new(Set[1], [4], rulebook)
puts nfa_design.accepts?('bab')
puts nfa_design.accepts?('bbbbb')
puts nfa_design.accepts?('bbabb')
=end

# 自由移動(epsilon遷移)の導入(p.78-79)
=begin
rulebook = NFARulebook.new([
    FARule.new(1, nil, 2), FARule.new(1, nil, 4),
    FARule.new(2, 'a', 3),
    FARule.new(3, 'a', 2),
    FARule.new(4, 'a', 5),
    FARule.new(5, 'a', 6),
    FARule.new(6, 'a', 4),
])
# puts rulebook.next_states(Set[1], nil)

# puts rulebook.follow_free_moves(Set[1])

nfa_design = NFADesign.new(1, [2, 4], rulebook)
puts nfa_design.accepts?('aa')
puts nfa_design.accepts?('aaa')
puts nfa_design.accepts?('aaaaa')
puts nfa_design.accepts?('aaaaaa')
=end

# NFAの開始状態を指定できるように拡張
rulebook = NFARulebook.new([
    FARule.new(1, 'a', 1), FARule.new(1, 'a', 2), FARule.new(1, nil, 2),
    FARule.new(2, 'b', 3),
    FARule.new(3, 'b', 1), FARule.new(3, nil, 2)
])

nfa_design = NFADesign.new(1, [3], rulebook)
=begin
puts nfa_design.to_nfa.crrnt_states
puts nfa_design.to_nfa(Set[2]).crrnt_states
puts nfa_design.to_nfa(Set[3]).crrnt_states

nfa = nfa_design.to_nfa(Set[2, 3])
nfa.read_char('b')
puts nfa.crrnt_states
=end

# 以降ではシミュレーション状態を単に状態と略記する
# 状態遷移を実装
simulation = NFASimulation.new(nfa_design)
=begin
# # puts simulation.next_state(Set[1, 2], 'a')
# # puts simulation.next_state(Set[1, 2], 'b')
# # puts simulation.next_state(Set[3, 2], 'b')
# # puts simulation.next_state(Set[1, 3, 2], 'b')
# # puts simulation.next_state(Set[1, 3, 2], 'a')
=end

# 特定の状態に対する全ての状態遷移を列挙
=begin
puts rulebook.alphabet
puts simulation.rules_for(Set[1, 2])
puts simulation.rules_for(Set[3, 2])
=end

# 全ての状態と状態遷移を列挙
=begin
start_state = nfa_design.to_nfa.crrnt_states
states, rules = simulation.discover_states_and_rules(
    Set[start_state]
)
# puts states
# puts rules
=end

# 列挙された状態が受理状態か
# puts nfa_design.to_nfa(Set[1, 2]).accepting?
# puts nfa_design.to_nfa(Set[1, 3]).accepting?

dfa_design = simulation.to_dfa_design
puts dfa_design.accepts?('aaa')
puts dfa_design.accepts?('aab')
puts dfa_design.accepts?('bbbabb')
