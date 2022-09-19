require_relative 'lexer'

print(LexicalAnalyzer.new('y = x * 7').analyze, "\n")
print(LexicalAnalyzer.new('while (x < 5) { x = x * 3 }').analyze, "\n")
print(LexicalAnalyzer.new('if (x < 10) { y = true; x = 0 } else { do-nothing }').analyze, "\n")
