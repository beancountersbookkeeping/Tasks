class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  def self.save_task_errors(params, current_user)
    @errors = ""
    @company = Company.find_by_id(params["anything"]["company_id"])
    @title = params["anything"]["title"]
    @recreate_task_days = params["anything"]["recreate_task_days"]
    if current_user == nil then @errors += "No logged user." 
    elsif @company == nil then @errors += "No company chosen."     
    end
    if @title == "" then @errors += "Title is empty." end
    if @recreate_task_days == "" then @errors += "Recreate task days is empty." end
    return @errors
  end

  def self.save_task(params, current_user)
    @errors = ""
    @company = Company.find_by_id(params["anything"]["company_id"])
    @title = params["anything"]["title"]
    @task = Task.new
    @task.title = @title
    @task.company_id = @company.id 
    @task.user_id = @company.user_id
    @task.recreate_task_days = params["anything"]["recreate_task_days"]
    @task.status = "Active"
    @task.save
  end

  def self.save_time(params)
    @task_id = params["task_id"]
    @task = Task.find_by_id(@task_id)
    @task.time = params["time"]
    @task.save
  end

  def self.create_todays_tasks
    @tasks = Task.all
    @today = Date.parse(Time.now.to_s)
    for @task in @tasks do
     if @task.recreate_task_days != nil and @task.recreate_task_days != 0 then
      @new_day = Date.parse((@task.created_at + @task.recreate_task_days.days).to_s)
      if @new_day == @today then 
        @new_task = Task.new
        @new_task.title = @task.title
        @new_task.recreate_task_days = @task.recreate_task_days
        @new_task.user_id = @task.user_id
        @new_task.company_id = @task.company_id
        @new_task.archived = @task.archived
        @new_task.status = "Active"
        @new_task.save
      end 
     end
    end
  end

  def self.generate_random_tasks(n)
    ActiveRecord::Base.connection.execute("delete from tasks")
    @user_ids = User.all.pluck(:id)
    @company_ids = Company.all.pluck(:id)
    ActiveRecord::Base.transaction do
     for @i in (1..n.to_i) do
       Task.create!(title: Faker::Lorem.sentence, user_id: @user_ids.sample.to_i, company_id: @company_ids.sample.to_i, archived: false, status: "Active", recreate_task_days: rand(1..10))
       if @i.to_i % 100 == 0 then 
	 puts @i.to_s + " random tasks have been generated."
       end
     end
    end
    puts n.to_s + " random tasks have been generated."
  end

  def self.complete_task(params)
    @id = params["id"]
    @task = Task.find_by_id(@id)
    if @task != nil then
      @task.status = "Completed"
      @task.save
    end
  end

  def self.activate_task(params)
    @id = params["id"]
    @task = Task.find_by_id(@id)
    if @task != nil then
      @task.status = "Active"
      @task.save
    end
  end



end
