require 'json'

class ExchangeController < ApplicationController
	def index
		@title = "Exchange"
	end

	def calculate 
		@order_book = HTTParty.get "https://www.bitstamp.net/api/order_book/"
		i = -1
		quantity = params['quantity'].to_f
		given = 0
		@price = 0
		if (params['transaction_type'] == 'bid')
			book = @order_book['bids']
		else 
			book = @order_book['asks']
		end
		while (quantity > given)
			i = i + 1
			#puts (book[i][1].to_f)
			puts quantity
			puts given
			puts book[i][1].to_f
			puts (quantity - given) > book[i][1].to_f
			if ((quantity - given) > book[i][1].to_f)
				given += book[i][1].to_f
				@price = @price + (book[i][0].to_f * (book[i][1].to_f / quantity))
			else
				@price = @price + (book[i][0].to_f * ((quantity - given) / quantity))
				given = quantity
			end
		end

		render 'show'
	end
end
