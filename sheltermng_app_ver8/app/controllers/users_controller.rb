class UsersController < ApplicationController
  before_action :authenticate_admin_user!, only: [:index]
  def new
    @user = User.new
  end


  def show
  end

  def index
    @users = User.all  
    @shelters =Shelter.all
    @users = User.order("created_at DESC") #並び替え
    #Serch用
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)


  end



  # def create
  #   @user = User.new()

  #   if @user.save
  #     redirect_to users_index_path(@user), notice: "ユーザ「#{@user.name}」を登録しました。"
  #   else
  #     render :new
  #   end
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      Shelter.increment_counter(:count, @user.shelter_id)
      redirect_to new_user_path, notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    # Shelter.crement_counter(:count, @user.shelter_id)
    redirect_to users_url, notice: "避難所 「#{@user.name}」を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name,:age, :sex, :remarks, :shelter_id)
    # params.require(:shelter).permit(:shelter_name)

    # current_shelter=User.find_by(code: params[:users][:current_shelter]).shelter_name
  end

end
