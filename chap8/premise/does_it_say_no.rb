require_relative 'evaluate'

program = $stdin.read

=begin
プログラムを自分自身を入力として実行した結果が
'no'であれば'yes'を出力
'no'でなければ'no'を出力
=end
if evaluate_on_itself(program) == 'no'
    puts 'yes'
else
    puts 'no'
end
