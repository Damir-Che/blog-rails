class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]



  def index
    @categories = Category.all
  end
  #---------------------------------------

  def show
    @posts = Post.where(category_id: [@category.subtree_ids]).paginate(page: params[:page], per_page: 6) #page: params[:page] - тек страница и per_page: 5 - ко-во постов отоб на одной странице
  end
  #---------------------------------------

  def new
    @category = Category.new
    @categories = Category.all.order(:name) # .order(:name) - отсортировать по имени
  end
  #---------------------------------------

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, success: 'Категория успешно создана'
    else
      @categories = Category.all.order(:name)
      flash[:danger] = 'Категория не создана'
      render :new
    end
  end
  #---------------------------------------

  def edit
    #where("id != #{@category.id}").order(:name) - Все категории за исключением текущей
    @categories = Category.where("id != #{@category.id}").order(:name)
  end
  #---------------------------------------

  def update
    if @category.update_attributes(category_params)
      redirect_to categories_path, success: 'Категория успешно обновлена'
    else
      #where("id != #{@category.id}").order(:name) - Все категории за исключением текущей
      @categories = Category.where("id != #{@category.id}").order(:name)
      flash[:danger] = 'Категория не обновлена'
      render :new
    end
  end
  #---------------------------------------

  def destroy
    @category.destroy
    redirect_to categories_path, success: 'Статья успешно удалена'#success- flash функции
  end
  #---------------------------------------


  private
  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
