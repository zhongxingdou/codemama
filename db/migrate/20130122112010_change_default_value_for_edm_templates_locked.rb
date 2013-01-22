class ChangeDefaultValueForEdmTemplatesLocked < ActiveRecord::Migration
  def up
    change_column_default(:edm_templates, :locked, false)
  end

  def down
    change_column_default(:edm_templates, :locked, true)
  end
end
