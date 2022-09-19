require_relative "../syntax/sequence.rb"

class Sequence
    def to_ruby
        # 1番目の文の評価結果が2番目の文の環境として使われる
        "-> env {  (#{second.to_ruby}).call((#{first.to_ruby}).call(env)) }"
    end
end
