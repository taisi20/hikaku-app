class HistoriesController < ApplicationController
  def index
    @histories = History.order.(id: :desc).page(params[:page])
  end

  def new
  end

  def create
  end
end
