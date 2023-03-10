# frozen_string_literal: true

def stock_prices(stocks)
  best = 0
  best_b = 0
  best_s = 0
  (0..stocks.length - 2).each do |i|
    (i + 1..stocks.length - 1).each do |j|
      next unless stocks[j] - stocks[i] > best

      best = stocks[j] - stocks[i]
      best_b = [i]
      best_s = [j]
    end
  end
  "#{best_b + best_s} For a total of $#{best} profit!"
end

puts stock_prices([17, 3, 6, 9, 15, 8, 6, 1, 10])
