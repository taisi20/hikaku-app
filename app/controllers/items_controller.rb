class ItemsController < ApplicationController
  def new
    @keyword = History.last
    @items = RakutenWebService::Ichiba::Item.search(keyword: @keyword.name)
    @items.first(10).each do |item|
      @item = Item.new(response: item, product_code: item["itemCode"], shop: "rakuten")
    end
  end

  def create
    @item = Item.new
    @item.save
  end
end
