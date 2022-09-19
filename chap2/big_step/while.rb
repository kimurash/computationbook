require_relative "../syntax/while.rb"

class While
    def evaluate(environment)
        case cond.evaluate(environment)
        when Boolean.new(true)
            # ループ本体を評価して新しい環境が返される
            # その環境を再び現在のメソッドに渡す
            self.evaluate(
                body.evaluate(environment)
            )
        when Boolean.new(false)
            environment
        end
    end
end
