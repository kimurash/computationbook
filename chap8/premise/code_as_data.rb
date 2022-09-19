# プログラムをバイト列に変換
program = "puts 'hello world'"
bytes_in_binary = program.bytes.map { |byte|
    byte.to_s(2).rjust(8, '0')
}
number = bytes_in_binary.join.to_i(2)

puts number

# バイト列をプログラムに変換して実行
bytes_in_binary = number.to_s(2).scan(/.+?(?=.{8}*\z)/)
program = bytes_in_binary.map { |string|
    string.to_i(2).chr
}.join

eval program
