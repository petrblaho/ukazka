class PagesController < ApplicationController
  before_action :authorize, only: [:secret]
  def main
    @my_user = User.find(1)
    render :main, locals: {user: User.find(2)}
  end

  def about
  end

  def secret
  end
end
