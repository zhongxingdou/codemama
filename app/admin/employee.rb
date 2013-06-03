ActiveAdmin.register Employee do
  form do |f|
    f.inputs "Employees" do
      f.input "gender", :as => :radio, :label => "Gender", :collection => [["Male", false], ["Female", true]]
      f.input "name"
      f.input "department"
      f.input "qq"
      f.input "index"
    end
    f.actions
  end
end
