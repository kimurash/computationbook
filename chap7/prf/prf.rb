# Partial Recursive Function

def zero
    0
end

def inc(n)
    n + 1
end

=begin
最後の入力が0なら残りの値を引数としてf呼び出す
最後の入力が0でなければデクリメントして
1. 更新された入力を引数として自分自身を呼びだす.
2. 更新された入力と1.の戻り値を引数としてgを呼び出す
=end
def recur(f, g, *values)
    # puts 'debug'
    *other_values, last_value = values

    if last_value.zero?
        send(f, *other_values)
    else
        easier_last_value = last_value - 1
        easier_values = other_values + [easier_last_value]

        easier_result = recur(f, g, *easier_values)
        send(g, *easier_values, easier_result)
    end
end

def minimize
    n = 0
    n = n + 1 until yield(n).zero?
    n
end

# 数
def two
    inc(inc(zero))
end

def three
    inc(two)
end

def six
    mult(two, three)
end

def ten
    inc(mult(three, three))
end

# 加算
def add_zero2x(x)
    x
end

def inc_easier_result(x, easier_y, easier_result)
    inc(easier_result)
end

def add(x, y)
    recur(:add_zero2x, :inc_easier_result, x, y)
end

# 乗算
def mult_x_by_zero(x)
    zero
end

def add_x2easier_result(x, easier_y, easier_result)
    add(x, easier_result)
end

def mult(x, y)
    recur(:mult_x_by_zero, :add_x2easier_result, x, y)
end

# デクリメント
def easier_x(easier_x, easier_result)
    easier_x
end

def decrement(x)
    recur(:zero, :easier_x, x)
end

# 減算
def sub_zero_from_x(x)
    x
end

def decrement_easier_result(x, easier_y, easier_result)
    decrement(easier_result)
end

def sub(x, y)
    recur(:sub_zero_from_x, :decrement_easier_result, x, y)
end

# 除算 see p.215
def divide(x, y)
    minimize { |n| sub(inc(x), mult(y, inc(n))) }
end


