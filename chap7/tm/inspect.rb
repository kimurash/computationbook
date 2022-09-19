require_relative 'tape'
require_relative '../../chap6/fizzbuzz/helpers.rb'

crrnt_tape = TAPE[EMPTY][ZERO][EMPTY][ZERO]
crrnt_tape = TAPE_WRITE[crrnt_tape][ONE]
crrnt_tape = TAPE_MOVE_HEAD_RIGHT[crrnt_tape]

crrnt_tape = TAPE_WRITE[crrnt_tape][TWO]
crrnt_tape = TAPE_MOVE_HEAD_RIGHT[crrnt_tape]

crrnt_tape = TAPE_WRITE[crrnt_tape][THREE]
crrnt_tape = TAPE_MOVE_HEAD_RIGHT[crrnt_tape]

puts to_array(TAPE_LEFT[crrnt_tape]).map { |p| to_integer(p) }.inspect
puts to_integer(TAPE_MIDDLE[crrnt_tape]).inspect
puts to_array(TAPE_RIGHT[crrnt_tape]).map { |p| to_integer(p) }.inspect
