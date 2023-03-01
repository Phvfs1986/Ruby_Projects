# frozen_string_literal: true

def substrings(string, dictionary)
  hash = {}
  dictionary.each do |word|
    if string.include?(word)
      hash[word] = hash[word].nil? ? 1 : hash[word] + 1
    end
  end
  hash
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
