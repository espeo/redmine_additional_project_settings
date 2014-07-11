module EspeoAdditionalProjectSettings
  AVAILABLE_LOCALES = [:pl, :en]

  module CustomFields
    DEFAULTS = {

      # DEPRECATED and changed to project#custom_start_date
      project_start_date: {
        id: 13371,
        name: I18n.t(:project_start_date),
        field_format: "date"
      },

      # DEPRECATED and changed to project#custom_end_date
      project_end_date: {
        id: 13372,
        name: I18n.t(:project_end_date),
        field_format: "date"
      },

      project_status: {
        id: 13373,
        name: I18n.t(:project_status),
        field_format: "list",
        possible_values: [
          I18n.t(:project_status_planned),
          I18n.t(:project_status_during),
          I18n.t(:project_status_done),
          I18n.t(:project_status_closed),
        ],
        # Temporary solution - enum_values are just for
        # - #get_enum_values_for_custom_field
        # - #get_real_values_for_enum_value
        # Thus, we can get the enum symbol for real value extracted 
        #   from the database (f.e. after translation).
        enum_values: [:planned, :during, :done, :closed]
      },

      project_deal_type: {
        id: 13374,
        name: I18n.t(:project_deal_type),
        field_format: "list",
        possible_values: [
          I18n.t(:project_deal_type_fixed_price),
          I18n.t(:project_deal_type_time_material),
          I18n.t(:project_deal_type_mixed),
        ],
        enum_values: [:fixed_price, :time_material, :mixed]
      },

      project_image: {
        id: 13375,
        name: I18n.t(:project_image),
        field_format: "image"
      }

    }

    def self.create_defaults!
      ProjectCustomField.transaction do
        DEFAULTS.values.map do |field_data|
          field_data = field_data.except :enum_values

          if field = ProjectCustomField.where(id: field_data[:id]).first
            field.attributes = field_data.except(:id)
            field.save!
          else
            # We use :without_protection to save models with given primary ID
            # (see http://stackoverflow.com/questions/431617/overriding-id-on-create-in-activerecord for more info)
            field = ProjectCustomField.create!(field_data, :without_protection => true)
          end
        end
      end
    end

    def self.get_enum_values_for_custom_field field_name
      DEFAULTS[field_name][:enum_values]
    end

    def self.get_real_values_for_enum_value field_name, enum_value
      translation_symbol = "#{field_name.to_s}_#{enum_value.to_s}"
      AVAILABLE_LOCALES.map do |locale|
        I18n.t translation_symbol, locale: locale
      end
    end

    def self.get_enum_value_for_real_value field_name, real_value
      get_enum_values_for_custom_field(field_name).find do |enum_value|
        get_real_values_for_enum_value(field_name, enum_value).include? real_value
      end      
    end

    def self.get_default_real_value_for_enum_value field_name, enum_value
      raise "Unknown enum_value for custom_field \"#{field_name}\"!" unless enum_value.in? get_enum_values_for_custom_field(field_name)
      
      translation_symbol = "#{field_name.to_s}_#{enum_value.to_s}"
      I18n.t translation_symbol
    end
    
  end
  
end
