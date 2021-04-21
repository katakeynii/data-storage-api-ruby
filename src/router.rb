module Router
    

    def draw(&block)
        eval_block(block)
        nil
    end
end