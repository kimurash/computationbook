# 非負の整数
ZERO    = -> p { -> x {       x    } }
ONE     = -> p { -> x {     p[x]   } }
TWO     = -> p { -> x {   p[p[x]]  } }
THREE   = -> p { -> x { p[p[p[x]]] } }
FIVE    = -> p { -> x { p[p[p[p[p[x]]]]] } }
FIFTEEN = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }

# ブール値
TRUE  = -> x { -> y { x } }
FALSE = -> x { -> y { y } }
IF    = -> b {
    -> x {
        -> y {
            b[x][y]
        }
    }
}

# 述語
IS_ZERO = -> n { n[-> x { FALSE }][TRUE] }

# ペア
PAIR  = -> x { -> y { -> f { f[x][y] } } }
LEFT  = -> p { p[-> x { -> y { x } } ] }
RIGHT = -> p { p[-> x { -> y { y } } ] }

# 数値演算
INCREMENT = -> n { -> p { -> x { p[n[p][x]] } } }
SLIDE     = -> p { PAIR[RIGHT[p]][INCREMENT[RIGHT[p]]] }
DECREMENT = -> n { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }
ADD       = -> m { -> n { n[INCREMENT][m] } }
SUBTRACT  = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY  = -> m { -> n { n[ADD[m]][ZERO] } }
POWER     = -> m { -> n { n[MULTIPLY[m]][ONE] } }

IS_LESS_OR_EQUAL =
    -> m { -> n {
        IS_ZERO[SUBTRACT[m][n]]
    }
}

# コンビネータ
Y = -> f { -> x { f[x[x]] }[-> x { f[x[x]] }] }
Z = -> f { -> x { f[-> y { x[x][y] }] }[-> x { f[-> y { x[x][y] }] }] }

MOD =
    # Fの再帰関数(不動点)を返す
    Z[-> f { # 入力された関数fを使う関数を返す関数F
        -> m { -> n {
            IF[IS_LESS_OR_EQUAL[n][m]][
                -> x {
                    f[SUBTRACT[m][n]][n][x]
                }
            ][
                m
            ]
        }}
    }
]

DIV =
    Z[-> f {
        -> m { -> n {
            IF[IS_LESS_OR_EQUAL[n][m]][
            -> x {
                INCREMENT[f[SUBTRACT[m][n]][n]][x]
            }
            ][
                ZERO
            ]
        }}
    }
]

# 連結リスト
EMPTY     = PAIR[TRUE][TRUE]
UNSHIFT   = -> l { -> x { PAIR[FALSE][PAIR[x][l]] } }
IS_EMPTY  = LEFT
FIRST     = -> l { LEFT[RIGHT[l]] } # 最初の要素
REST      = -> l { RIGHT[RIGHT[l]] } # RESETというよりはNEXT

# 範囲
RANGE =
    Z[-> f {
        -> m { -> n {
            IF[IS_LESS_OR_EQUAL[m][n]][
                -> x {
                    UNSHIFT[f[INCREMENT[m]][n]][m][x]
                }
            ][
                EMPTY
            ]
        }}
    }
]

# 畳み込み
=begin
see <http://www.ndis.co.jp/blog/tech/2008/09/fold.html>
当サイトではfoldlに当たるメソッドとしてinject()メソッドが挙がっている.
このFOLDはinject()と少し似ているとあり,
    f (... (f (f (f z x_n) x_n-1) x_n-2) ...) x_1
のように実装されているはず.
=end
FOLD =
    # f: 
    Z[ -> f {
        # l: リスト
        # x: 初期値
        # g: 2項演算関数
        -> l { -> x { -> g {
        IF[IS_EMPTY[l]][ # リストが空であれば
            x
        ][
            -> y {
                g[ f[REST[l]][x][g] ][ FIRST[l] ][y]
            }
        ]
        }}}
    }]

# mapメソッド
MAP = 
    # k: リスト
    # f: 全要素に施す関数
    -> k { -> f { # l<-k, x<-EMPTY
        FOLD[k][EMPTY][
            # l: リスト
            # x: 要素
            # 要素xに関数fを施して先頭に連結していく
            -> l { -> x { UNSHIFT[l][f[x]] } }
        ]
    }}

PUSH =
    -> l {
        -> x {
            FOLD[l][UNSHIFT[EMPTY][x]][UNSHIFT]
        }
    }

# 文字列
TEN = MULTIPLY[TWO][FIVE]
B   = TEN
F   = INCREMENT[B]
I   = INCREMENT[F]
U   = INCREMENT[I]
ZED = INCREMENT[U] # Zコンビネータを上書きしないための定数名

FIZZ     = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][I]][F]
BUZZ     = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][U]][B]
FIZZBUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[BUZZ][ZED]][ZED]][I]][F]

# 数から文字列への変換
NINE = MULTIPLY[THREE][THREE]
TO_DIGITS =
    Z[-> f { -> n { PUSH[
        # このブロック内がprevious_digits
        IF[IS_LESS_OR_EQUAL[n][DECREMENT[NINE]]][
            EMPTY
        ][
            -> x {
                f[DIV[n][TEN]][x]
            }
        ]
        ][MOD[n][TEN]]
    }}
    ]

# FizzBuzz問題
SOLUTION = MAP[RANGE[ONE][FIFTEEN]][-> n {
    IF[IS_ZERO[MOD[n][FIFTEEN]]][
        FIZZBUZZ
    ][IF[IS_ZERO[MOD[n][THREE]]][
        FIZZ
    ][IF[IS_ZERO[MOD[n][FIVE]]][
        BUZZ
    ][
        TO_DIGITS[n]
    ]]]
}]


# プログラミングテクニック
# 0の無限ストリーム
ZEROS = Z[-> f { UNSHIFT[f][ZERO] }]

# 与えられた数から順に数え上げる
UPWARDS_OF = Z[-> f {-> n {
        UNSHIFT[ -> x {f[INCREMENT[n]][x]} ][n]
    }
}]

# 与えられた数の倍数のストリーム
MULTIPLES_OF =
    -> m {
        Z[-> f {-> n {
            # n = mのはず
            UNSHIFT[-> x { f[ADD[m][n]][x] }][n]
        }}
    ][m]
}

# ２つのストリームを組み合わせる
MULTIPLY_STREAMS =
    Z[-> f {
        -> k { -> l {
            UNSHIFT[
                -> x { f[REST[k]][REST[l]][x] }
            ][
                MULTIPLY[FIRST[k]][FIRST[l]]
            ]
        } }
    }]

# フィボナッチ数列
FIBNACCI =
    Z[-> f { -> n {
        IF[IS_LESS_OR_EQUAL[n][ONE]][ # n <= 1
            IF[IS_ZERO[n]][ # n == 0
                ZERO
            ][ # n == 1
                ONE
            ]
        ][ # n > 1
            -> x {
                ADD[ f[SUBTRACT[n][ONE]] ][ f[SUBTRACT[n][TWO]] ][x]
            }
        ]
    }}
    ]

# 再帰の回避
# MOD
=begin
MOD =
    -> m { -> n {
        m[-> x {
            IF[IS_LESS_OR_EQUAL[n][x]][ # n <= x
                SUBTRACT[x][n]
            ][
                x
            ]
        }][m]
    }}
=end

# RANGE
COUNTDOWN = -> p {
    PAIR[ UNSHIFT[LEFT[p]][RIGHT[p]] ][ DECREMENT[RIGHT[p]] ]
}

=begin
RANGE = -> m { -> n {
    LEFT[
        # COUNTDOWN[ n-m[COUNTDOWN][((T, T), n)] ]
        INCREMENT[
            SUBTRACT[n][m]
        ][
            COUNTDOWN
        ][
            PAIR[EMPTY][n]
        ]
    ]
}}
=end
