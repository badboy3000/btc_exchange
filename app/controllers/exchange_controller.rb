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
			if (i >= book.length)
				@price = nil
				break
			end
			
			if ((quantity - given) > book[i][1].to_f)
				given += book[i][1].to_f
				if (params['transaction_currency'] == 'btc')
					@price = @price + (book[i][0].to_f * (book[i][1].to_f / quantity))
				else
					@price = @price + ((1 / book[i][0].to_f) * (book[i][1].to_f / quantity))
				end
			else
				if (params['transaction_currency'] == 'btc')
					@price = @price + (book[i][0].to_f * ((quantity - given) / quantity))
				else
					@price = @price + (( 1 / book[i][0].to_f) * ((quantity - given) / quantity))
				end	
				given = quantity
			end
		end

		if (params['transaction_currency'] == 'btc') 
			@format = 0
		else 
			@format = 1
		end

		if @price 
		@commission = @price * 0.01 # I would set this as a static variable if I had time
		if (params['transaction_type'] == 'bid') 	
			@total = @price - @commission
		else
			@total = @price + @commission
		end
		end

		render 'show'
	end
end
