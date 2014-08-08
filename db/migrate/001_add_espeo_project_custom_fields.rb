class AddEspeoProjectCustomFields < ActiveRecord::Migration
  def self.up
    EspeoAdditionalProjectSettings::CustomFields.create_defaults!
  end

  def self.down
    # Here we should delete all the created CustomFields ... 
    # ... but let's skip it and just leave them in the database.
  end
end
