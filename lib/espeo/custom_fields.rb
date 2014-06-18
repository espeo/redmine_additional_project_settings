module Espeo
  module CustomFields
    DEFAULTS = {
      project_start_date: {
        id: 13371,
        name: I18n.t(:project_start_date),
        field_format: "date"
      },
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
      },
      project_deal_type: {
        id: 13374,
        name: I18n.t(:project_deal_type),
        field_format: "list",
        possible_values: [
          I18n.t(:deal_type_fixed_price),
          I18n.t(:deal_type_time_material),
          I18n.t(:deal_type_mixed),
        ],
      },
      project_image: {
        id: 13375,
        name: I18n.t(:project_image),
        field_format: "image"
      }
    }

    def self.create_defaults!
      # We use :without_protectionto save models with given primary ID
      # (see http://stackoverflow.com/questions/431617/overriding-id-on-create-in-activerecord for more info)
      ProjectCustomField.create!(DEFAULTS.values, :without_protection => true)
    end
  end
end
