require 'json'

class ExchangeController < ApplicationController
	def index
		@title = "Exchange"
	end

	def calculate 
		@order_book = HTTParty.get "https://www.bitstamp.net/api/order_book/"
		count
		quantity = params['quantity']
		given = 0
		if (params['transaction_type'] == 'bid')
			while (quantity > given)
				given += @order_book['bids'][count][1]
				count = count + 1
			
		else 
			while (qauntity > given)
				@order_book['asks'][count]
		end

		# go through and calculated to bid_count
		for i in 0..count

		render :nothing => :true
	end
end
