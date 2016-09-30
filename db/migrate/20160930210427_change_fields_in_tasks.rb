class ChangeFieldsInTasks < ActiveRecord::Migration
  def change
    change_column(:tasks, :completion_status, :boolean)
    change_column(:tasks, :completed_at, :datetime)
  end
end
