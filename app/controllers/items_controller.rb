class ItemsController < ApplicationController
  def search
    keyword = History.order(updated_at: :desc).first
    associated_item = HistoriesItem.where(history_id: keyword.id)
    if associated_item
      fresh_data = associated_item.order(searched_at: :desc).first
    end
    today = Date.today
    recode = HistoriesItem.find_by(history_id: keyword.id)
    #historyテーブルから同じ文字列が見つかるか見つからないかで条件分岐
    if recode
      #前回の検索が5日以内の検索結果か5日以内より古いかで条件分岐
      if  fresh_data.searched_at.to_i >= today.ago(5.days).to_i
        items = RakutenWebService::Ichiba::Item.search(keyword: keyword.name).first(5)
        #items.countが０（検索結果があるかないか）で条件分岐
        if items.count == 0
          redirect_to root_url
          flash[:danger] = "検索結果が見つかりませんでした。"
        else
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
        end
        @items = keyword.searched_items.order(searched_at: :desc).first(5)
      else
        @items = keyword.searched_items.order(searched_at: :desc).first(5)
      end
    else
      items = RakutenWebService::Ichiba::Item.search(keyword: keyword.name).first(5)
      #items.countが０（検索結果があるかないか）で条件分岐
      if items.count == 0
        redirect_to root_url
        flash[:danger] = "検索結果が見つかりませんでした。"
      else
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
      end
      @items = keyword.searched_items.order(searched_at: :desc).first(5)
    end
  end
end
