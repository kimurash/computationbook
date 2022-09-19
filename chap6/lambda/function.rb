class Function < Struct.new(:param, :body)
    def to_s
        "-> #{self.param} { #{self.body} }"
    end

    def inspect
        self.to_s
    end

    def replace(name, replacement)
        if self.param == name
            self
        else
            Function.new(self.param,
                         self.body.replace(name, replacement))
        end
    end

    def call(arg)
        self.body.replace(self.param, arg)
    end

    def callable?
        true
    end

    def reducible?
        false
    end
end
