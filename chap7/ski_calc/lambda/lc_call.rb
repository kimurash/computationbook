require_relative '../../../chap6/lambda/call'
require_relative '../ski_call'

class Call
    def to_ski
        SKICall.new(self.left.to_ski, self.right.to_ski)
    end
end
