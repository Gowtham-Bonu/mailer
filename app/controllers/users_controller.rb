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
      UserMailer.with(user: @user).welcome_email.deliver_later
      redirect_to root_path, notice: "user successfully created!"
    else
      flash.now[:alert] = [@user.errors.full_messages].join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      if @user.saved_changes.includes?(:email)
        UserMailer.with(user: @user).email_changed.deliver_later
      end
      redirect_to root_path, notice: "user successfully updated!"
    else
      flash.now[:alert] = [@user.errors.full_messages].join(", ")
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
