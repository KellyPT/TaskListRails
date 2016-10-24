class Task < ActiveRecord::Base
  belongs_to :user

  def task_completed
    self.completion_status = true
    self.save
  end

  def update_completed_at
    self.completed_at = Time.now
    self.save
  end
end
