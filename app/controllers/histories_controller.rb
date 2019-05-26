class HistoriesController < ApplicationController
  def index
    @history = History.new
    @histories = History.order(count: :desc).page(params[:page]).per(20)
  end

  def new
    @history = History.new
  end

  def create
    @histories = History.order(count: :desc).page(params[:page]).per(20)
    @history = History.new(history_params)
    if @history.save
      flash[:success] = "正常に検索されました。"
      redirect_to histories_path
    else
      flash.now[:danger] = "検索に失敗しました。"
      render :index
    end
  end
  
  private
  #strong_parameters
  def history_params
    params.require(:history).permit(:name)
  end
end
