def bubble_sort(bubble)
  length = bubble.size
  loop do 
    return p bubble if length <= 1
    for i in 1..length - 1
      if bubble[i - 1] > bubble[i]
        temp = bubble[i - 1]
        bubble[i - 1] = bubble[i]
        bubble[i] = temp
      end
    end
    length -= 1
  end
end

bubble_sort([4, 3, 78, 2, 0, 2])