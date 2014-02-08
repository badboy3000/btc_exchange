class ExchangeController < ApplicationController
	def index
		@order_book = HTTParty.get "https://www.bitstamp.net/api/order_book/"

	end
end
