require_relative '../../chap6/fizzbuzz/only_proc.rb'

# コンストラクタ
TAPE        = -> l { -> m { -> r { -> b { PAIR[PAIR[l][m]][PAIR[r][b]] } } } }
# アクセッサ
TAPE_LEFT   = -> t { LEFT[LEFT[t]] }
TAPE_MIDDLE = -> t { RIGHT[LEFT[t]] }
TAPE_RIGHT  = -> t { LEFT[RIGHT[t]] }
TAPE_BLANK  = -> t { RIGHT[RIGHT[t]] }

# テープと文字を受け取って,テープの中央にその文字を書いたテープを返す
TAPE_WRITE = -> t { -> c {
    TAPE[TAPE_LEFT[t]][c][TAPE_RIGHT[t]][TAPE_BLANK[t]]
}}

TAPE_MOVE_HEAD_RIGHT =
-> t {
    TAPE[
        PUSH[TAPE_LEFT[t]][TAPE_MIDDLE[t]]
    ][
        IF[IS_EMPTY[TAPE_RIGHT[t]]][
            TAPE_BLANK[t]
        ][
            FIRST[TAPE_RIGHT[t]]
        ]
    ][
        IF[IS_EMPTY[TAPE_RIGHT[t]]][
            EMPTY
        ][
            REST[TAPE_RIGHT[t]]
        ]
    ][
        TAPE_BLANK[t]
    ]
}

=begin
#TAPE_MOVE_HEAD_LEFTの実装もよく似ているが,
6章で定義しなかったリスト操作を追加する必要がある.
末尾の要素を削除する関数, POP
=end
