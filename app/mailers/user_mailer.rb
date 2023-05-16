class UserMailer < ApplicationMailer
  default from: "gowthambonu99@gmail.com"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "welcome email!")
  end

  def email_changed
    @user = params[:user]
    mail(to: @user.email, subject: "email_updated!") do |format|
      format.html { render layout: 'email_layout' }
      format.text
    end
  end
end
