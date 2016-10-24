class TasksController < ApplicationController

  before_action :find_task, only: [:show, :edit, :update, :delete, :destroy, :complete]

  # The 'require_login' action in Application Controller will apply here. Only authenticated user can have access to the below actions.
  def index
    @tasks = @current_user.tasks
  end

  def show
    # @task = Task.find(params[:id])
    # if @task.user_id == session[:user_id]
    #   @task
    # else
    #   render :no_show
    # end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = session[:user_id]
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def edit
    # @task = Task.find(params[:id])
    # if @task.user_id == session[:user_id]
    #   @task
    # else
    #   render :no_show
    # end
  end

  def update
    # @task = Task.find(params[:id])
    # if @task.user_id == session[:user_id]
    #   @task
    # else
    #   render :no_show
    # end
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def delete
    # @task = Task.find(params[:id])
  end

  def destroy
    # @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  # This method Complete below corresponds to the button_to. Nothing will output to the screen. But behind the scene, the Complete method will update the Task entry by calling 2 methods in Task model task.rb. If the user clicks on the Details section, he/she will see the changes to Completion Status and Completed At date.
  def complete
    # @task = Task.find(params[:id])
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

    # The following condition will make sure that a logged-in user cannot use index, show, edit, update, delete, destroy, complete actions on tasks that does not belong to them.
    if @task.user_id == session[:user_id]
      @task
    else
      render :no_show
    end
  end

end
