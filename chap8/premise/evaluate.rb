require 'stringio'

=begin
標準入力からRubyプログラムと引数を受取り,
そのプログラムをに引数を与えて評価した結果を
標準週力に返す
=end
def evaluate(program, input)
    old_stdin, old_stdout = $stdin, $stdout
    $stdin, $stdout = StringIO.new(input), (output = StringIO.new)

    begin
        eval program
    rescue Exception => e
        output.puts(e)
    ensure
        $stdin, $stdout = old_stdin, old_stdout
    end

    output.string
end

# evaluate('print $stdin.read.reverse', 'hello world')

# プログラム自体を入力として評価する
def evaluate_on_itself(program)
    evaluate(program, program)
end

# evaluate_on_itself('print $stdin.read.reverse')

