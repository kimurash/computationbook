class CyclicTagEncoder < Struct.new(:alphabet)
    # 1文字ずつエンコードして連結
    def encode_string(string)
        string.chars.map{ |char|
            self.encode_char(char)
        }.join
    end

    def encode_char(char)
        char_pos = self.alphabet.index(char)
        (0..self.alphabet.length - 1).map{ |n|
            n == char_pos ? '1' : '0'
        }.join
    end
end