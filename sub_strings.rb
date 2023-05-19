# frozen_string_literal: true

def substring(string, dictionary)
  hash = {}
  string = string.downcase
  dictionary.each do |word|
    count = string.scan(word).length
    hash[word] = count if count.positive?
  end
  puts hash
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

substring("Howdy partner, sit down! How's it going?", dictionary)
