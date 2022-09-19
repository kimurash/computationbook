require_relative "../syntax/do_nothing.rb"

class DoNothing
    def to_ruby
        # [HELP]: 'を用いることで式展開しないことを明治?
        '-> env { env }'
    end
end
