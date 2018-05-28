module CompanysHelper
  def add_task_link(name)
    link_to name do |page|
      page.insert_html :bottom, :tasks, :partial => 'task', :object => Task.new
    end
  end
end
