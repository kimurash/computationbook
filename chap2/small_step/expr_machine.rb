class ExpressionMachine < Struct.new(:expression, :environment)
    def step
        self.expression = expression.reduce(environment)
    end

    def run
        while expression.reducible?
            puts expression
            self.step
        end
        puts expression
    end
end
