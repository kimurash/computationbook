require_relative "../syntax/number.rb"

class Number
    def to_ruby
=begin
    - 表示的意味論を構築するときに重要なのは
      元の言語にある構成要素の特性を表現すること

    - この場合の式は環境を使わないが,
      一般的に式は環境を必要とするという概念を表現している
=end
        "-> env { #{value.inspect} }"
    end
end