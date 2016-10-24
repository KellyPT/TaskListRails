class TasksController < ApplicationController

  before_action :find_task, only: [:show, :edit, :update, :delete, :destroy, :complete]

  # The 'require_login' action in Application Controller will apply here. Only authenticated user can have access to the below actions.
  def index
    @tasks = @current_user.tasks
  end

  def show; end

  def new
    @task = @current_user.tasks.new
  end

  def create
    @task = @current_user.tasks.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def delete; end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  # This method Complete below corresponds to the button_to. Nothing will output to the screen. But behind the scene, the Complete method will update the Task entry by calling 2 methods in Task model task.rb. If the user clicks on the Details section, he/she will see the changes to Completion Status and Completed At date.
  def complete
    @task.task_completed
    @task.update_completed_at
    redirect_to task_path(@task.id)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :completion_status, :completed_at)
  end

  def find_task
    begin
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "public/404", status: :not_found
    end

    # The following condition will make sure that a logged-in user CANNOT use 'index', 'show', 'edit', 'update', 'delete', 'destroy', 'complete' actions on tasks that DOES NOT belong to them.
    if @task.user_id == session[:user_id]
      @task
    else
      render :no_show
    end
  end

end
