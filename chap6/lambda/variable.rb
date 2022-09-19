class Variable < Struct.new(:name)
    def to_s
        name.to_s
    end

    def inspect
        self.to_s
    end

    def replace(name, replacement)
        if self.name == name
            replacement
        else
            self
        end
    end

    def callable?
        false
    end

    def reducible?
        false
    end
end
