class HistoriesController < ApplicationController
  def index
    @history = History.new
    @histories = History.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def create
    @histories = History.order(updated_at: :desc).page(params[:page]).per(10)
    @history = History.new(history_params)
    if searched?(@history.name)
      history = History.find_by(name: @history.name)
      history.count = history.count + 1
      history.save
      flash[:success] = "正常に検索されました。"
      redirect_to search_path
    else
      if @history.save
        flash[:success] = "正常に検索されました。"
        redirect_to search_path
      else
        flash.now[:danger] = "検索に失敗しました。"
        render :index
      end
    end
  end
  
  private
  
  #strong_parameters
  def history_params
    params.require(:history).permit(:name, :count)
  end
  
  def searched?(keyword)
    History.find_by(name: keyword)
  end
end
