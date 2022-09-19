module Pattern
    def matches?(string)
        self.to_nfa_design.accepts?(string)
    end
    
    # precedence: 優先度
    def bracket(outer_precedence)
        # 自身の優先度よりも相手の優先度の方が高い場合
        if self.precedence < outer_precedence
            '(' + to_s + ')'
        else
            to_s
        end
    end

    def inspect
        "/#{self}/"
    end
end