class CommunityController < ApplicationController
  helper :profile
  def index
    @title = "Community"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
    if params[:id]
      @initial = params[:id]
      @specs =  Spec.where("last_name like ?","#{@initial}%").paginate(:page => params[:page], per_page: 10).order("last_name,first_name")
      @users = @specs.collect { |spec| spec.user }
    end
  end

  def browse
  end

  def search
  end
end
