class TasksController < ApplicationController
  def index
    @task_list = [
      "Task 1: Eat",
      "Task 2: Sleep",
      "Task 3: Exercise",
      "Task 4: Do homework"
    ]
  end

  def show
    @task_details = [
      {name: "Eat" , description: "Eat well" , completion_status: "Yes" , completed_date: "15th Sep 2016"},
      {name: "Sleep" , description: "Sleep well" , completion_status: "No" , completed_date: "16th Sep 2016"},
      {name: "Exercise" , description: "Biking or brisk-walking" , completion_status: "No", completed_date: "18th Sep 2016"},
      {name: "Do homework" , description: "Finish homework of the day" , completion_status: "No", completed_date: "19th Sep 2016" }
    ]

    @task_id = params[:id].to_i
  end
end
