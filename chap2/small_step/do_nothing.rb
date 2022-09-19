=begin
- プログラムの実行が正しく終了したことを
  示すための特別な構文
- 他の文がやるべきこと終えると最終的に
  <<do-nothing>>に簡約されるように実装する
=end

# Struct.new()には空のリストを渡せないため
# Structクラスを継承していない
class DoNothing
    def to_s
        'do-nothig'
    end

    def inspect
        "<<#{self}>>"
    end

    # 他の構文クラスはStructクラスから継承するが
    # DoNothingは自分で定義
    def ==(other_statement)
        other_statement.instance_of?(DoNothing)
    end

    def reducible?
        false
    end
end
