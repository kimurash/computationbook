class Type < Struct.new(:name)
    NUM, BOOL = [:num, :bool].map{ |name|
        self.new(name)
    }
    VOID = self.new(:void)

=begin
    今更気づいたけど,本書の実装を律儀に守らなくてもこうしておけば,
    わざわざ puts var.inspect と書かなくてもよかったのでは?
=end
    def to_s
        "#<Type #{self.name}>"
    end

    def inspect
        self.to_s
    end
end