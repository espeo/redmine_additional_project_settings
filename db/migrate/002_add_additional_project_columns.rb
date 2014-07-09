class AddAdditionalProjectColumns < ActiveRecord::Migration
  def self.up
    add_column :projects, :custom_start_date, :date
    add_column :projects, :custom_end_date, :date

    Project.reset_column_information
    Project.find_each do |project|
      project.attributes = {
        custom_start_date: project.legacy_start_date, 
        custom_end_date: project.legacy_end_date
      }
      project.save!
    end

    custom_field_ids = EspeoAdditionalProjectSettings::CustomFields::DEFAULTS.slice(:project_start_date, :project_end_date).map{|y, x| x[:id]}
    ProjectCustomField.where(id: custom_field_ids).destroy_all
  end

  def self.down
    remove_column :projects, :custom_start_date
    remove_column :projects, :custom_end_date
  end
end
