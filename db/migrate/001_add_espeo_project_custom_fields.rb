class AddEspeoProjectCustomFields < ActiveRecord::Migration
  def self.up
    Espeo::CustomFields.create_required_custom_fields!
  end

  def self.down
    raise "Not implemented"
  end
end
