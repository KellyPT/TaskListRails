class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
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

  # This method Complete below corresponds to the button_to. Nothing will output to the screen. But behind the scene, the Complete method will update the Task entry by calling 2 methods in Task model task.rb. If the user clicks on the Details section, he/she will see the changes to Completion Status and Completed At date.
  def complete
    @task = Task.find(params[:id])
    @task.task_completed
    @task.update_completed_at

    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :completion_status, :completed_at)
  end
end
