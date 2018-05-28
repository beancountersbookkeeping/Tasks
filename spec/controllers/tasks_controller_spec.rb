require 'rails_helper'

RSpec.describe tasksController, type: :controller do
  
  let(:my_task) { task.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_task] to @tasks" do
       get :index
       expect(assigns(:tasks)).to eq([my_task])
     end
  end

   describe "GET show" do
     it "returns http success" do
       get :show, {id: my_task.id}
       expect(response).to have_http_status(:success)
     end
     it "renders the #show view" do
       get :show, {id: my_task.id}
       expect(response).to render_template :show
     end
 
     it "assigns my_task to @task" do
       get :show, {id: my_task.id}
       expect(assigns(:task)).to eq(my_task)
     end
   end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
     it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end
 
      it "instantiates @task" do
        get :new
        expect(assigns(:task)).not_to be_nil
      end
    end
 
    describe "task create" do
      it "increases the number of task by 1" do
        expect{task :create, task: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(task,:count).by(1)
      end
 
      it "assigns the new task to @task" do
        task :create, task: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:task)).to eq task.last
      end
 
      it "redirects to the new task" do
        task :create, task: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to task.last
      end
    end
  end

   describe "GET edit" do
     it "returns http success" do
       get :edit, {id: my_task.id}
       expect(response).to have_http_status(:success)
     end
 
     it "renders the #edit view" do
       get :edit, {id: my_task.id}
       expect(response).to render_template :edit
     end
 
     it "assigns post to be updated to @post" do
       get :edit, {id: my_task.id}
 
       task_instance = assigns(:task)
 
       expect(task_instance.id).to eq my_task.id
       expect(task_instance.title).to eq my_task.title
       expect(task_instance.body).to eq my_task.body
     end
   end

