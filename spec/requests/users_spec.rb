require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user){ User.create(valid_attributes) }

  let(:valid_attributes) { { name: "uswder2", email: "qwewqeonu99@wdgmail.com"} }

  let(:invalid_attributes) { { name: "", email: ""} }

  describe "index" do
    it "get to index and genrate a successful response" do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "new" do
    it "get to new and render a successful response" do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "create" do
    context "with valid parameters" do
      it "create a user" do
        expect {
          post users_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        expect(response).to redirect_to root_path
      end

      it "send an email if the user is created" do
        user = User.new(valid_attributes)
        expect { UserMailer.with(user: user).welcome_email.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "with invalid parameters" do
      it "do not create a user" do
        expect {
          post users_path, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "edit" do
    it "should go to edit action" do
      get edit_user_path(user)
      expect(response).to be_successful
    end
  end

  describe "update" do
    context "valid parameters" do
      let(:new_valid_parameters) {{name: "changed", email: "changed@mail.com"}}
      it "should update the user" do
        patch user_path(user), params: {user: new_valid_parameters}
        user.reload
        expect(response).to redirect_to root_path
      end

      it "check if email is updated" do
        old_email = valid_attributes[:email]
        new_email = new_valid_parameters[:email]
        expect(old_email).not_to eq(new_email)
      end

      it "send an updated email" do
        expect {
          UserMailer.with(user: user).email_changed.deliver_now
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "with invalid parameters" do
      let(:new_invalid_parameters) {{name: ""}}
      it "should not update user" do
        patch user_path(user), params: {user: new_invalid_parameters}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
