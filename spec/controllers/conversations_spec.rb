require 'spec_helper'
require "rails_helper"

RSpec.describe ConversationsController, type: :controller do
  include Devise::Test::ControllerHelpers
  
  describe "GET index" do
    login_user
    # before_action :authenticate_user!
    # it "#index" do
    #   get :index
    #   expect(response).to have_http_status(200)
    # end

    it "returns conversations in inbox box" do
      get :index#, box: "inbox"
      expect(response).to have_http_status(200)
    end
  end
end

