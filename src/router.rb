module Router
    
    def regitry
        @registry = Registry.new
    end
    def draw(&block)
        eval_block(block)
        nil
    end
end