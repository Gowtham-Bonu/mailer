require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  setup do
    @user = create(:user)
    @welcome_mail = UserMailer.with(user: @user).welcome_email.deliver_now
    @update_mail = UserMailer.with(user: @user).email_changed.deliver_now
  end

  context "welcome_email" do
    it "renders receiver mail" do
      expect(@welcome_mail.to).to eq([@user.email])
    end
  
    it "renders sender mail" do
      expect(@welcome_mail.from).to eq(["gowthambonu99@gmail.com"])
    end
  end

  context "update_email" do
    it "renders receiver mail" do
      expect(@update_mail.to).to eq([@user.email])
    end
  
    it "renders sender mail" do
      expect(@update_mail.from).to eq(["gowthambonu99@gmail.com"])
    end
  end
end