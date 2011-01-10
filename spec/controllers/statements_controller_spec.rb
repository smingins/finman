require 'spec_helper'

describe StatementsController do

  describe "GET 'import'" do
    it "should be successful" do
      get 'import'
      response.should be_success
    end
  end

end
