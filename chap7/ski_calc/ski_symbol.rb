require_relative 'ski_call'
require_relative 'ski_combinator'

# クラス名をSymbolにするとエラーを吐かれたので
# SKISymbolに変更

class SKISymbol < Struct.new(:name)
    def to_s
        name.to_s
    end

    def inspect
        self.to_s
    end

    def combinator
        self
    end

    def arguments
        []
    end

    def callable?(*argumnets)
        false
    end

    def reducible?
        false
    end

    # 1つの引数で呼び出されると元のSKI式に戻るような新しいSKI式に変換する
    # 新しいSKI式はnameを引数とする関数として振る舞う
    def as_function_of(name)
        if self.name == name
            I
        else
            SKICall.new(K, self)
        end
    end

    def to_iota
        self
    end
end
