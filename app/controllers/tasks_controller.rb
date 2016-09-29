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
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to tasks_path
      else
        render :edit
      end
  end

  def delete
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    redirect_to tasks_path
  end
  private

  def task_params
    params.require(:task).permit(:title, :name, :description, :completion_status, :completed_at)
  end
end
