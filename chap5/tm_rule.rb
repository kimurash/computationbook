require_relative 'tm_config'

class TMRule < Struct.new(:state, :char, :next_state,
                          :char_to_write, :direction)
    def follow(config)
        TMConfiguration.new(
            self.next_state,
            self.next_tape(config)
        )
    end

    def next_tape(config)
        written_tape = config.tape.write(self.char_to_write)

        case self.direction
        when :left
            written_tape.move_head_left
        when :right
            written_tape.move_head_right
        end
    end

    # 本規則を適用できるか?
    def applies_to?(config)
        self.state == config.state &&
        self.char == config.tape.middle
    end

    
end