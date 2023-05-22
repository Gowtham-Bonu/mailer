class UserMailer < ApplicationMailer
  before_action :set_receiver
  
  default from: "gowthambonu99@gmail.com"

  def welcome_email
    mail(to: @user.email, subject: "welcome email!")
  end

  def email_changed
    mail(to: @user.email, subject: "email_updated!") do |format|
      format.html { render layout: 'email_layout' }
      format.text
    end
  end

  private

  def set_receiver
    @user = params[:user]
  end
end
