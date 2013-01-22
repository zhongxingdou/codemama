class ChangeDefaultValueForEdmsLocked < ActiveRecord::Migration
  def up
    change_column_default(:edms, :locked, false)
  end

  def down
    change_column_default(:edms, :locked, true)
  end
end
