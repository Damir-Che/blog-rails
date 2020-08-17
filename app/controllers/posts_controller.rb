class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  #---------------------------------------

  def index
    # @posts = Post.all
    @posts = Post.paginate(page: params[:page], per_page: 6) #page: params[:page] - тек страница и per_page: 5 - ко-во постов отоб на одной странице
  end
  #---------------------------------------

  def show
  end
  #---------------------------------------


  def new
    @post = Post.new
  end
  #---------------------------------------


  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, success: 'Статья успешна создана'#success- flash функции
    else
      flash.now[:danger] = 'Статья не создана' #danger- flash функции
      render :new
    end
  end
  #---------------------------------------


  def edit
  end
  #---------------------------------------


  def update
    if @post.update_attributes(post_params)
      redirect_to @post, success: 'Статья успешно обновлена' #success- flash функции
    else
      flash.now[:danger] = 'Статья не обновлена' #danger- flash функции
      render :edit
    end
  end
  #---------------------------------------


  def destroy
    @post.destroy
    redirect_to posts_path, success: 'Статья успешно удалена'#success- flash функции
  end
  #--------------------------------------


  private

  def post_params
    params.require(:post).permit(:title,:summary, :body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
