class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_parents, only: [:index, :show]

  def show
    # @items = @category.items の記述では、@categoryが孫の場合しか商品情報を取得出来ないため、モデルメソッド set_itemsにより、カテゴリー内の適切な商品を取得する
    @items = @category.set_items
    @items = @items.where(buyer_id: nil).order("created_at DESC").page(params[:page]).per(30)
  end

  private
  def set_category
    @category = Category.find(params[:id])

    if @category.has_children?
      @category_links = @category.children
    else
      # siblings：兄弟レコード（同じ階層のレコード）を返す
      @category_links = @category.siblings
    end
  end
end
