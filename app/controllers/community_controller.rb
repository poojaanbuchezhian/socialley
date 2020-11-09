class CommunityController < ApplicationController
  before_action :protect
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
    @title = "Browse"
    return if params[:commit].nil?
    if valid_input?
      specs = Spec.find_by_asl(params)
      @specs=Spec.where(:id=>specs).paginate(:page=>params[:page],per_page:10).order("last_name,first_name")
      @users = @specs.collect { |spec| spec.user }
    end
  end
  def valid_input?
    @spec = Spec.new
    zip_code = params[:zip_code]
    @spec.zip_code = zip_code
    location = GeoDatum.find_by_zip_code(zip_code)
    if not zip_code.blank? and location.nil?
      @spec.errors.add(:zip_code, "does not exist in our database")
    end
    if not params[:min_age].valid_int? and params[:max_age].valid_int?
      @spec.errors.add("Check", "Age range")
    end
    if params[:max_age] < params[:min_age]
      @spec.errors.add("Check", "Age range")
    end
    miles = params[:miles]
    if miles and not zip_code
      @spec.errors.add(:zip_code, "can't be blank")
    end
    if miles.nil? or not miles.valid_float?
      @spec.errors.add("Fill", "Location radius, Zip code")
    end
    @spec.errors.empty?
  end

  def search
    @title = "Search Socialley"
    if params[:q]
      query = params[:q]
      list=[]
      @users = User.with_query(query)
      specs = Spec.with_query(query)
      faqs = Faq.with_query(query)
      hits = specs + faqs
      hits.collect { |hit| list<<hit.user }
      @users=@users + list
      @users=@users.uniq
      @users.each { |user| user.spec ||= Spec.new }
      @users = @users.sort_by { |user| user.spec.last_name }
      @users=User.where(:id=>@users).paginate(:page=>params[:page],per_page:10)
      if @users.size === 0
        @invalid = true
      end
   end
 end
end
