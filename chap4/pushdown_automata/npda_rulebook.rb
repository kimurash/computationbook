require 'set'

class NPDARulebook < Struct.new(:rules)
    # 自由移動によって到達可能な全ての構成を見つける
    def follow_free_moves(configs)
        more_configs = self.next_configs(configs, nil)

        # next_configsで見つかった構成が既に含まれているか
        if more_configs.subset?(configs)
            configs
        else
            follow_free_moves(configs + more_configs)
        end
    end


    def next_configs(configs, char)
        configs.flat_map{ |config|
            self.follow_rules_for(config, char)
        }.to_set
    end
    
    # 規則に従って状態遷移ならぬ構成遷移
    def follow_rules_for(config, char)
        self.rules_for(config, char).map{ |rule|
            rule.follow(config)
        }
    end

    # 適用できる規則を見つける
    def rules_for(config, char)
        self.rules.select { |rule|
            rule.applies_to?(config, char)
        }
    end
end