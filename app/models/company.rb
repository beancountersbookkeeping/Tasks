class Company < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  def self.save_company_errors(params, current_user)
    @errors = ""
    @name = params["company"]["name"]
    if current_user == nil then @errors += "No logged in user."
    elsif @name == "" then @errors += "Company name is empty."
    end
    if @name != "" then 
      @company = Company.find_by_name(@name)
      if @company != nil then 
        @errors += "Company name already exists."
      end
    end
    return @errors
  end

  def self.save_company(params, user_id)
    @company = Company.new
    @company.name = params["company"]["name"]
    @company.user = user_id
    @company.save
  end

  def self.update_company_errors(params)
    @errors = ""
    @company = Company.find_by_id(params["company"]["id"])
    @name = params["company"]["name"]
    @user_id = params["company"]["user_id"]
    if @company == nil then @errors += "Company not found."
    elsif @name == "" then @errors += "Company name is empty."
    elsif @user_id == "" then @errors += "User ID is empty."
    end
    return @errors
  end

  def self.update_company(params)
    @company = Company.find_by_id(params["company"]["id"])
    @company.name = params["company"]["name"]
    @company.user_id = params["company"]["user_id"]
    @company.save
  end

  def self.destroy_company(company)
    Task.where(:company_id => company.id).destroy_all
    company.destroy
  end

  def self.generate_random_companies(n)
    ActiveRecord::Base.connection.execute("delete from companies")
    @user_ids = User.all.pluck(:id)
    ActiveRecord::Base.transaction do
     for @i in (1..n.to_i) do
       Company.create!(name: Faker::Company.name, user_id: @user_ids.sample.to_i)
     end
    end
    puts n.to_s + " random companies have been generated."
  end

end
