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
    def get_custom_value(custom_field_key, build_new = false)
      custom_field_id = EspeoAdditionalProjectSettings::CustomFields::DEFAULTS[custom_field_key][:id]

      custom_field_values.find do |value|
        value.custom_field_id == custom_field_id
      end || (CustomFieldValue.new(custom_field: ProjectCustomField.find(custom_field_id)) if build_new)
    end

    def legacy_start_date
      value = get_custom_value(:project_start_date)
      begin
        Date.parse(value.value) if value.present?
      rescue
      end
    end

    def legacy_end_date
      value = get_custom_value(:project_end_date)
      begin
        Date.parse(value.value) if value.present?
      rescue
      end
    end

    # Returns CustomFieldValue which stores the project's image.
    def custom_image
      get_custom_value(:project_image)
    end

    # Returns the ImageUploader for the project's image, if present.
    def custom_image_uploader
      if custom_image
        @custom_image_uploader ||= Redmine::FieldFormat::ImageFormat.uploader_for(custom_image.custom_field, self, custom_image.value)
      end
    end

    def espeo_status
      custom_field_name = :project_status
      custom_field_value = get_custom_value(custom_field_name)

      EspeoAdditionalProjectSettings::CustomFields.get_enum_value_for_real_value(custom_field_name, custom_field_value.value) if custom_field_value
    end

    def espeo_status=(status)
      custom_field_name = :project_status
      custom_field_value = get_custom_value(custom_field_name, true)
      
      custom_field_value.value = EspeoAdditionalProjectSettings::CustomFields.get_default_real_value_for_enum_value custom_field_name, status
    end
  end
end

Rails.application.config.to_prepare do
  Project.send :include, EspeoAdditionalProjectSettings::Patches::ProjectPatch
end
