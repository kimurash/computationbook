class PDAConfiguration < Struct.new(:state, :stack)
    STUCK_STATE = Object.new # 行き詰まり状態

    def stuck
        PDAConfiguration.new(STUCK_STATE, self.stack)
    end

    def stuck?
        state == STUCK_STATE
    end
end