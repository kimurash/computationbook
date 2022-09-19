def halts?(program, input)
    if program.include?('while true')
        if program.include?('input.include?(\'goodbye\')')
            if input.include?('goodbye')
                false
            else
                true
            end
        else
            false
        end
    else
        true
    end
end


always = "input = $stdin.read\nputs input.upcase"
puts halts?(always, 'hello world')

never = "input = $stdin.read\nwhile true\n# do nothing\nend\nputs input.upcase"
puts halts?(never, 'hello world')

sometimes = "input = $stdin.read\nif input.include?('goodbye')\nwhile true\n# do nothing\nend\nelse\nputs input.upcase\nend"
puts halts?(sometimes, 'hello world')
puts halts?(sometimes, 'goodbye world')
