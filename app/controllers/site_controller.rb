class SiteController < ApplicationController
  def index
    @title = "Welcome to Socialley!"
  end

  def about
      @title = "About Socialley!"
  end

  def help
      @title = "Socialley help!"
  end
end
