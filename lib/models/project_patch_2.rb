module ProjectPatch2
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    
  end
  
  module InstanceMethods
    def custom_start_date
      @custom_start_date ||= begin
        date_value = CustomValue.where(
          custom_field_id: Espeo::CustomFields::DEFAULTS[:project_start_date][:id], 
          customized_id: self.id, 
          customized_type: self.class.name
        ).pluck(:value).first
        Date.parse(date_value) if date_value
      end
    end

    def custom_end_date
      @custom_end_date ||= begin
        date_value = CustomValue.where(
          custom_field_id: Espeo::CustomFields::DEFAULTS[:project_start_date][:id], 
          customized_id: p.id, 
          customized_type: p.class.name
        ).pluck(:value).first
        Date.parse(date_value) if date_value
      end
    end
  end
end

Rails.application.config.to_prepare do
  Project.send :include, ProjectPatch2
end
