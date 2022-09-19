class StatementMachine < Struct.new(:statement, :environment)
    def step
        self.statement, self.environment = statement.reduce(environment)
    end

    def run
        while statement.reducible?
            puts "#{statement}, #{environment}"
            self.step
        end

        puts "#{statement}, #{environment}"
    end
end
