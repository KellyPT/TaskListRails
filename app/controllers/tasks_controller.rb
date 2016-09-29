class TasksController < ApplicationController
  def index
    @tasks = Task.all

    # [
    #   "Task 1: Eat",
    #   "Task 2: Sleep",
    #   "Task 3: Exercise",
    #   "Task 4: Do homework"
    # ]
  end

  def show
    @task = Task.find(params[:id])

    # @task_details = [
    #   {name: "Eat" , description: "Eat well" , completion_status: "Yes" , completed_date: "15th Sep 2016"},
    #   {name: "Sleep" , description: "Sleep well" , completion_status: "No" , completed_date: "16th Sep 2016"},
    #   {name: "Exercise" , description: "Biking or brisk-walking" , completion_status: "No", completed_date: "18th Sep 2016"},
    #   {name: "Do homework" , description: "Finish homework of the day" , completion_status: "No", completed_date: "19th Sep 2016" }
    # ]
    #
    # @task_id = params[:id].to_i
  end

  def new
  end

  def create
    Task.create(
      title: params[:title],
      name: params[:name],
      description: params[:description],
      completion_status: params[:completion_status],
      completed_at: params[:completed_at]
    )

    redirect_to tasks_path
  end
end
