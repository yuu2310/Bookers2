class UsersController < ApplicationController
  before_action :a, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # 特定のユーザ（@user）に関連付けられた投稿全て（.books）を取得し
    # @booksに渡す という処理を行うことができます。
    # 結果的に、全体の投稿ではなく、個人が投稿したもの全てを表示できます。
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def a
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end
end
