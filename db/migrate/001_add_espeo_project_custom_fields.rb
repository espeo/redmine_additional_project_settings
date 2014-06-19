class AddEspeoProjectCustomFields < ActiveRecord::Migration
  def self.up
    Espeo::CustomFields.create_defaults!
  end

  def self.down
    raise "Not implemented"
  end
end
