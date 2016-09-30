class Task < ActiveRecord::Base
  def task_completed
    self.completion_status = true
    save
  end

  def update_completed_at
    self.completed_at = Time.now
    save
  end
end
