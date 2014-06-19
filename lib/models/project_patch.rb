module ProjectPatch
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods

    base.class_eval do
      has_many :project_role_budgets, inverse_of: :project, :dependent => :delete_all
      has_many :wages, inverse_of: :project, :dependent => :delete_all
    end
  end

  module ClassMethods
    
  end
  
  module InstanceMethods
    def start_date
      CustomValue.where(id: Espeo::CustomFields::DEFAULTS[:project_start_date][:id], customized_id: self.id, customized_type: self.class.name).pluck(:value).first
    end

    def end_date
      CustomValue.where(id: Espeo::CustomFields::DEFAULTS[:project_end_date][:id], customized_id: self.id, customized_type: self.class.name).pluck(:value).first
    end
  end
end

Rails.application.config.to_prepare do
  Project.send :include, ProjectPatch
end
