def stock_picker prices 
	buy_day = 0
	sell_day = 0 
	profit = 0 

	prices.each_with_index do |buy_price, index|
		prices[index+1..-1].each_with_index do |sell_price, index2|
			if (sell_price - buy_price > profit)
				profit = sell_price - buy_price
				buy_day = index
				sell_day = index + index2 + 1
			end
		end
	end
	puts "The best day to buy is #{buy_day}, and best day to sell is #{sell_day} for a profit of $#{profit}"
end

stock_picker([17,3,6,9,15,8,6,1,10])