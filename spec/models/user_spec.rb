require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  it { should validate_presence_of(:email) }
  
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }

  it { should respond_to(:auth_token) }
  it { should validate_uniqueness_of(:auth_token) }

  describe "#generate authentication token for user!" do
    it 'generates an auth token' do
      Devise.stub(:friendly_token).and_return('token12345')
      @user.generate_authentication_token!
      expect(@user.auth_token).to eq('token12345')
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "token12345")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
