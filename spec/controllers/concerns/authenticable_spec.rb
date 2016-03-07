require 'spec_helper'

class Authentication
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe '#current_user' do
    before do
      @user = FactoryGirl.create(:user)
      request.headers['Authorization'] = @user.auth_token
      authentication.stub(:request).and_return(request)
    end
    it 'returns a user from the authentication header' do
      expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end
end

