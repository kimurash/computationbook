require_relative "../syntax/while.rb"

class While
    def to_ruby
        # ;を付けているのは評価した結果を返さないためか
        "-> env {" +
        "   while (#{cond.to_ruby}).call(env);" +
        "       env = (#{body.to_ruby}).call(env);" +
        "   end;" +
        "   env" +
        "}"
    end
end
