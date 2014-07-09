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
    def get_custom_value(custom_field_key)
      custom_field_values.find do |value|
        value.custom_field_id == EspeoAdditionalProjectSettings::CustomFields::DEFAULTS[custom_field_key][:id]
      end
    end

    def legacy_start_date
      value = get_custom_value(:project_start_date)
      Date.parse(value.value) if value.present?
    end

    def legacy_end_date
      value = get_custom_value(:project_end_date)
      Date.parse(value.value) if value.present?
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

    # Is this project in the "PLANNED" status?
    def espeo_planned?
      false
    end
  end
end

Rails.application.config.to_prepare do
  Project.send :include, EspeoAdditionalProjectSettings::Patches::ProjectPatch
end
