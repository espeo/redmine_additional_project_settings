module EspeoAdditionalProjectSettings::Patches::ProjectPatch
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods

    base.class_eval do
      safe_attributes "custom_start_date", "custom_end_date"
    end
  end

  module ClassMethods
  end
  
  module InstanceMethods
    def legacy_start_date
      @legacy_start_date ||= begin
        date_value = CustomValue.where(
          custom_field_id: EspeoAdditionalProjectSettings::CustomFields::DEFAULTS[:project_start_date][:id], 
          customized_id: self.id, 
          customized_type: self.class.name
        ).pluck(:value).first
        Date.parse(date_value) if date_value.present?
      end
    end

    def legacy_end_date
      @legacy_end_date ||= begin
        date_value = CustomValue.where(
          custom_field_id: EspeoAdditionalProjectSettings::CustomFields::DEFAULTS[:project_end_date][:id], 
          customized_id: self.id, 
          customized_type: self.class.name
        ).pluck(:value).first
        Date.parse(date_value) if date_value.present?
      end
    end
  end
end

Rails.application.config.to_prepare do
  Project.send :include, EspeoAdditionalProjectSettings::Patches::ProjectPatch
end
