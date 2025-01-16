class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :set_list

  def edit
  end

  def new
    @item = @list.items.build
  end

  def create
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to lists_path, notice: "Item criado com sucesso!"
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to lists_path, notice: "Item atualizado com sucesso!"
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :status)
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def set_list
    @list = Lists.find(params[:id])
  end
end
