# frozen_string_literal: true

def bubble_sort(bubble)
  length = bubble.size
  loop do
    return print bubble if length <= 1

    (1..length - 1).each do |i|
      next unless bubble[i - 1] > bubble[i]

      temp = bubble[i - 1]
      bubble[i - 1] = bubble[i]
      bubble[i] = temp
    end
    length -= 1
  end
end

bubble_sort([4, 3, 78, 2, 0, 2])
