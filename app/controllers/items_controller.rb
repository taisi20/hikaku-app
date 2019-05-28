class ItemsController < ApplicationController
  def search
    keyword = History.order(updated_at: :desc).first
    associated_item = HistoriesItem.where(history_id: keyword.id)
    if associated_item
      fresh_data = associated_item.order(searched_at: :desc).first
    end
    today = Date.today
    recode = HistoriesItem.find_by(history_id: keyword.id)
    if recode
      if  fresh_data.searched_at.to_i >= today.ago(5.days).to_i
        items = RakutenWebService::Ichiba::Item.search(keyword: keyword.name).first(5)
        items.first(5).each do |item|
          item = Item.new(response: item, product_code: item["itemCode"], shop: "rakuten")
          item.save
          if HistoriesItem.find_by(history_id: keyword.id, item_id: item.id)
            histories_item = HistoriesItem.find(item_id: item.id)
            histories_item.update(searched_at: Time.now)
          else
            item.histories_items.create(history_id: keyword.id, searched_at: Time.now)
          end
        end
        @items = keyword.searched_items.order(searched_at: :desc).first(5)
      else
        @items = keyword.searched_items.order(searched_at: :desc).first(5)
      end
    else
      items = RakutenWebService::Ichiba::Item.search(keyword: keyword.name).first(5)
      items.first(5).each do |item|
        item = Item.new(response: item, product_code: item["itemCode"], shop: "rakuten")
        item.save
        if HistoriesItem.find_by(history_id: keyword.id, item_id: item.id)
          histories_item = HistoriesItem.find(item_id: item.id)
          histories_item.update(searched_at: Time.now)
        else
          item.histories_items.create(history_id: keyword.id, searched_at: Time.now)
        end
      end
      @items = keyword.searched_items.order(searched_at: :desc).first(5)
    end
  end
end
