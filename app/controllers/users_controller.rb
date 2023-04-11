class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to root_path, notice: "user successfully created!"
    else
      flash.now[:alert] = "User not created!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    old_email = @user.email
    if @user.update(user_params)
      new_email = @user.email
      if old_email != new_email
        UserMailer.with(user: @user).email_changed.deliver_now
      end
      redirect_to root_path, notice: "user successfully updated!"
    else
      flash.now[:alert] = "User not updated!"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
