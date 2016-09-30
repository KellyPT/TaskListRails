class RemoveNameFieldFromTask < ActiveRecord::Migration
  def change
    remove_column(:tasks, :name)
  end
end
