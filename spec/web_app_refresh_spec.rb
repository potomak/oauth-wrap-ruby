require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'ostruct'

module OauthWrap
  describe WebApp, '#refresh' do
    before :each do
      WebMock.reset_webmock
      FakeOauthServer.new.start
      @web_app = OauthWrap.
        as_web_app(:authorization_url => Fixtures::AUTH_URL, :refresh_url => Fixtures::REFRESH_URL).
        as(*Fixtures::VALID_CREDENTIALS.first).
        with_tokens(Fixtures::ACCOUNTS.first)
    end
    
    it "issues a POST requets to the auth-server" do
      @web_app.refresh
      WebMock.should have_requested(:post, Fixtures::REFRESH_URL).once
    end
  end
end