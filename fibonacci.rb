# frozen_string_literal: true

def fibs_rec(number)
  return [] if number.zero?
  return [0] if number == 1
  return [0, 1] if number == 2

  rec = fibs_rec(number - 1)
  rec << rec[- 2] + rec[- 1]
  rec
end

def fibs(n)
  array = []
  (n + 1).times do |number|
    array << if number < 1
               0
             elsif number == 2
               1
             else
               ((array[number - 1]) + (array[number - 2]))
             end
  end
  array.shift
  array.join(' ')
end

puts fibs_rec(5)

puts fibs(5)
