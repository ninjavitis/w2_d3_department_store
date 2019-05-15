class ItemsController < ApplicationController
  before_action :set_department
  before_action :set_item, only:[:show, :edit, :update, :destroy]
  
  def index
    @items = @department.items
  end

  def show
  end

  def new
    @item = @department.items.new
    render partial: "form"
  end

  def create
    @item = @department.items.new(item_params)
    if @item.save
      redirect_to department_item_path(@department.id, @item.id)
    else
      render partial: "form"
    end
  end

  def edit
    render partial: "form"
  end

  def update
    if @item.update(item_params)
      redirect_to department_item_path(@department.id, @item.id)
    else
      render partial: "form"
    end
  end

  def destroy
    @item.destroy
    redirect_to department_items_path(@department.id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :style)
  end

  def set_department
    @department = Department.find(params[:department_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
