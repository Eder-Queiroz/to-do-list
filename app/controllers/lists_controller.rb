class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update ]

  def index
    @lists = List.all
  end

  def edit
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path, notice: "Lista criada com sucesso!"
    else
      render :new
    end
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path, notice: "Lista atualizada com sucesso!"
    else
      render :edit
    end
  end

  def show
  end

  private
  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = Lists.find(params[:id])
  end
end
