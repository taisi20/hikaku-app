class HistoriesController < ApplicationController
  def index
    @history = History.new
    @histories = History.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @history = History.new
  end

  def create
    @histories = History.order(id: :desc).page(params[:page]).per(20)
    @history = History.new(history_params)
    if @history.new_record?
      if @history.save
        flash[:success] = "正常に検索されました。"
        redirect_to new_item_path
      else
        flash.now[:danger] = "検索に失敗しました。"
        render :index
      end
    #else ここにすでに検索されている文字列も場合の処理をかく
    end
  end
  
  private
  #strong_parameters
  def history_params
    params.require(:history).permit(:name)
  end
end
