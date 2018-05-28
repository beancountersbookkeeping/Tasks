desc "This task is called by the Heroku scheduler add-on"
task :create_tasks => :environment do
  puts "Creating today's tasks"
  Task.create_todays_tasks
  puts "done."
end

