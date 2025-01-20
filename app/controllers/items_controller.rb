class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: %i[ edit update destroy update_status ]

  def edit
    render "form"
  end

  def new
    @item = @list.items.build
    render "form"
  end

  def create
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to list_path(@list), notice: "Item criado com sucesso!"
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to list_path(@list), notice: "Item atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to list_path(@list), notice: "Item excluído com sucesso."
  end

  def update_status
    if @item.update(status: params[:status])
      render json: { success: true }
    else
      render json: { success: false, error: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :status)
  end
end
