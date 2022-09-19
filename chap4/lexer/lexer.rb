class LexicalAnalyzer < Struct.new(:string)
    GRAMMAR = [
        { token: 'i', pattern: /if/         }, # if keyword
        { token: 'e', pattern: /else/       }, # else keyword
        { token: 'w', pattern: /while/      }, # while keyword
        { token: 'd', pattern: /do-nothing/ }, # do-nothing keyword
        { token: '(', pattern: /\(/         }, # opening bracket
        { token: ')', pattern: /\)/         }, # closing bracket
        { token: '{', pattern: /\{/         }, # opening curly bracket
        { token: '}', pattern: /\}/         }, # closing curly bracket
        { token: ';', pattern: /;/          }, # semicolon
        { token: '=', pattern: /=/          }, # equals sign
        { token: '+', pattern: /\+/         }, # addition sign
        { token: '*', pattern: /\*/         }, # multiplication sign
        { token: '<', pattern: /</          }, # less-than sign
        { token: 'n', pattern: /[0-9]+/     }, # number
        { token: 'b', pattern: /true|false/ }, # boolean
        { token: 'v', pattern: /[a-z]+/     }  # variable name
    ]

    def analyze
        [].tap do |tokens|
            while self.more_tokens?
                tokens.push(self.next_token)
            end
        end
    end

    def more_tokens?
        !self.string.empty?
    end

    # 次のトークンを切り出す
    def next_token
        rule, match = self.rule_matching(string)
        self.string = self.string_after(match)
        rule[:token]
    end

    def rule_matching(string)
        matches = GRAMMAR.map { |rule| self.match_at_beginning(rule[:pattern], string) }
        # マッチしなかったパターンは除去
        rules_with_matches = GRAMMAR.zip(matches).reject { |rule, match| match.nil? }
        # 最長一致したパターンを選択
        self.rule_with_longest_match(rules_with_matches)
    end

    def match_at_beginning(pattern, string)
        /\A#{pattern}/.match(string)
    end

    def rule_with_longest_match(rules_with_matches)
        rules_with_matches.max_by { |rule, match| match.to_s.length }
    end

    def string_after(match)
        match.post_match.lstrip
    end
end
