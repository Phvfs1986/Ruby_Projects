def caesar_cipher(string, shift)
  letters = string.split(//)
  letters.each do |letter|
    if letter =~ /[a-z]/
      print ((((letter.ord + shift) - 97) % 26) + 97).chr
    elsif letter =~ /[A-Z]/
      print ((((letter.ord + shift) - 65) % 26) + 65).chr
    elsif letter == ' '
      print letter
    elsif print letter
      print letter
    end
  end
  puts
end

print 'Enter a string to encode: '
string = gets.chomp
print 'Enter the shift factor: '
shift = gets.chomp.to_i
caesar_cipher(string, shift)
