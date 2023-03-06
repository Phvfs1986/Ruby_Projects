# frozen_string_literal: true

to_sort = [5, 7, 3, 1, 6, 2, 4, 8]

def merge_sort(array)
  return array if array.length <= 1

  middle = array.length / 2
  left = array.take(middle)
  right = array.drop(middle)

  left_sorted = merge_sort(left)
  right_sorted = merge_sort(right)

  merge_halves(left_sorted, right_sorted)
end

def merge_halves(left, right)
  sorted = []

  until left.empty? || right.empty?
    if left.first < right.first
      sorted << left.shift
    elsif left.first == right.first
      sorted << left.shift
      sorted << right.shift
    else
      sorted << right.shift
    end
  end
  sorted + left + right
end

puts merge_sort(to_sort).join(', ')
