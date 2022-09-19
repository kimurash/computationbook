require_relative 'ski_call'
require_relative 'ski_symbol'

=begin
S, K, IをSymbolのインスタンスとしてもよいが,
Symbolクラスのサブクラスのインスタンスとすることで
3つのコンビネータオブジェクトにメソッドを追加するのが
簡単になる
=end
class SKICombinator < SKISymbol
    def as_function_of(name)
        SKICall.new(K, self)
    end
end

S, K, I = [:S, :K, :I].map { |name| SKICombinator.new(name) }
IOTA = SKICombinator.new(:i)

# それぞれに簡約規則を実装してスモールステップ意味論を与える
class << S
    # S[a][b][c] --> a[c][b[c]]
    def call(a, b, c)
        SKICall.new(SKICall.new(a, c), SKICall.new(b, c))
    end

    def callable?(*arguments)
        arguments.length == 3
    end

    def to_iota
        SKICall.new(
            IOTA,
            SKICall.new(
                IOTA,
                SKICall.new(
                    IOTA,
                    SKICall.new(
                        IOTA,
                        IOTA)
                )
            )
        )
    end
end

class << K
    # K[a][b] --> a
    def call(a, b)
        a
    end

    def callable?(*arguments)
        arguments.length == 2
    end

    def to_iota
        SKICall.new(
            IOTA,
            SKICall.new(
                IOTA, 
                SKICall.new(
                    IOTA,
                    IOTA
                )
            )
        )
    end
end

class << I
    # I[a] --> a
    def call(a)
        a
    end

    def callable?(*arguments)
        arguments.length == 1
    end

    def to_iota
        SKICall.new(IOTA, IOTA)
    end
end

class << IOTA
    # reduce i[a] to a[S][K]
    def call(a)
        SKICall.new(SKICall.new(a, S), K)
    end

    def callable?(*arguments)
        arguments.length == 1
    end
end
