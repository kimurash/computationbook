require_relative 'dtm_rulebook'
require_relative 'dtm'
require_relative 'tape'
require_relative 'tm_config'
require_relative 'tm_rule'

# テープの導入
tape = Tape.new(['1', '0', '1'],'1',[],'_')
=begin
puts tape.inspect
puts tape.middle
=end

# ヘッダの移動を実装
=begin
puts tape.inspect
tape = tape.move_head_left
tape = tape.write('0')
tape = tape.move_head_right
tape = tape.move_head_right.write('0')
puts tape.inspect
=end

# TM規則の導入
# 状態1で0を読むと,それを1で上書きし,ヘッドを右に動かし,状態2へと遷移
rule = TMRule.new(1, '0', 2, '1', :right)
=begin
puts rule.applies_to?(TMconfig.new(1, Tape.new([], '0', [], '_')))
puts rule.applies_to?(TMconfig.new(1, Tape.new([], '1', [], '_')))
puts rule.applies_to?(TMconfig.new(2, Tape.new([], '0', [], '_')))
=end

# 構成遷移を実装
=begin
puts rule.follow(
    TMconfig.new(
        1, Tape.new([], '0', [], '_')
    )
)
=end

# DTM規則集を導入
# 2進数をインクリメントするTM規則
rulebook = DTMRulebook.new([
    TMRule.new(1, '0', 2, '1', :right),
    TMRule.new(1, '1', 1, '0', :left),
    TMRule.new(1, '_', 2, '1', :right),
    TMRule.new(2, '0', 2, '0', :right),
    TMRule.new(2, '1', 2, '1', :right),
    TMRule.new(2, '_', 3, '_', :left)
])
=begin
config = TMconfig.new(1, tape)
config = rulebook.next_config(config)
config = rulebook.next_config(config)
config = rulebook.next_config(config)
puts config
=end

# DTMの導入
=begin
dtm = DTM.new(TMconfig.new(1, tape), [3], rulebook)
puts dtm.crrnt_config
puts dtm.accepting?

puts dtm.step

puts dtm.crrnt_config
puts dtm.accepting?

dtm.run

puts dtm.crrnt_config
puts dtm.accepting?
=end

# 行き詰まり状態になるとエラーを吐く
=begin
tape = Tape.new(['1', '2', '1'], '1', [], '_')
dtm = DTM.new(TMconfig.new(1, tape), [3], rulebook)
dtm.run
=end
# -> undefined method `follow' for nil:NilClass (NoMethodError)

# 行き詰まり状態を解決
=begin
dtm = DTM.new(TMconfig.new(1, tape), [3], rulebook)
dtm.run
puts dtm.crrnt_config
puts dtm.accepting?
puts dtm.stuck?
=end

# 1文字以上のaにbとcが続く文字列を受理するDTM(see p.140)
=begin
rulebook = DTMRulebook.new([
    # state 1: scan right looking for a
    TMRule.new(1, 'X', 1, 'X', :right), # skip X
    TMRule.new(1, 'a', 2, 'X', :right), # cross out a, go to state 2
    TMRule.new(1, '_', 6, '_', :left),  # find blank, go to state 6 (accept)

    # state 2: scan right looking for b
    TMRule.new(2, 'a', 2, 'a', :right), # skip a
    TMRule.new(2, 'X', 2, 'X', :right), # skip X
    TMRule.new(2, 'b', 3, 'X', :right), # cross out b, go to state 3

    # state 3: scan right looking for c
    TMRule.new(3, 'b', 3, 'b', :right), # skip b
    TMRule.new(3, 'X', 3, 'X', :right), # skip X
    TMRule.new(3, 'c', 4, 'X', :right), # cross out c, go to state 4

    # state 4: scan right looking for end of string
    TMRule.new(4, 'c', 4, 'c', :right), # skip c
    TMRule.new(4, '_', 5, '_', :left),  # find blank, go to state 5

    # state 5: scan left looking for beginning of string
    TMRule.new(5, 'a', 5, 'a', :left),  # skip a
    TMRule.new(5, 'b', 5, 'b', :left),  # skip b
    TMRule.new(5, 'c', 5, 'c', :left),  # skip c
    TMRule.new(5, 'X', 5, 'X', :left),  # skip X
    TMRule.new(5, '_', 1, '_', :right)  # find blank, go to state 1
])
tape = Tape.new([], 'a', ['a', 'a', 'b', 'b', 'b', 'c', 'c', 'c'], '_')
dtm = DTM.new(TMConfiguration.new(1, tape), [6], rulebook)

10.times { dtm.step }
puts dtm.crrnt_config

25.times { dtm.step }
puts dtm.crrnt_config

dtm.run
puts dtm.crrnt_config
=end


# TMの計算能力の検証
# 内部ストレージ
=begin
rulebook = DTMRulebook.new([
    # state 1: read the first character from the tape
    TMRule.new(1, 'a', 2, 'a', :right), # remember a
    TMRule.new(1, 'b', 3, 'b', :right), # remember b
    TMRule.new(1, 'c', 4, 'c', :right), # remember c

    # state 2: scan right looking for end of string (remembering a)
    TMRule.new(2, 'a', 2, 'a', :right), # skip a
    TMRule.new(2, 'b', 2, 'b', :right), # skip b
    TMRule.new(2, 'c', 2, 'c', :right), # skip c
    TMRule.new(2, '_', 5, 'a', :right), # find blank, write a

    # state 3: scan right looking for end of string (remembering b)
    TMRule.new(3, 'a', 3, 'a', :right), # skip a
    TMRule.new(3, 'b', 3, 'b', :right), # skip b
    TMRule.new(3, 'c', 3, 'c', :right), # skip c
    TMRule.new(3, '_', 5, 'b', :right), # find blank, write b

    # state 4: scan right looking for end of string (remembering c)
    TMRule.new(4, 'a', 4, 'a', :right), # skip a
    TMRule.new(4, 'b', 4, 'b', :right), # skip b
    TMRule.new(4, 'c', 4, 'c', :right), # skip c
    TMRule.new(4, '_', 5, 'c', :right)  # find blank, write c
])

tape = Tape.new([], 'b', ['c', 'b', 'c', 'a'], '_')
dtm = DTM.new(TMConfiguration.new(1, tape), [5], rulebook)
dtm.run
puts dtm.crrnt_config.tape.inspect
=end

# サブルーチン
def increment_rules(start_state, return_state)
    incrementing = start_state
    finishing = Object.new
    finished = return_state

    [
        TMRule.new(incrementing, '0', finishing,    '1', :right),
        TMRule.new(incrementing, '1', incrementing, '0', :left),
        TMRule.new(incrementing, '_', finishing,    '1', :right),
        TMRule.new(finishing,    '0', finishing,    '0', :right),
        TMRule.new(finishing,    '1', finishing,    '1', :right),
        TMRule.new(finishing,    '_', finished,     '_', :left)
    ]
end

added_zero, added_one, added_two, added_three = 0, 1, 2, 3

rulebook = DTMRulebook.new(
    increment_rules(added_zero, added_one) +
    increment_rules(added_one, added_two) +
    increment_rules(added_two, added_three)
)
puts rulebook.rules.length

tape = Tape.new(['1', '0', '1'], '1', [], '_')
dtm = DTM.new(TMConfiguration.new(added_zero, tape), [added_three], rulebook)
dtm.run
puts dtm.crrnt_config.tape.inspect
