module EspeoAdditionalProjectSettings
  class Hooks < Redmine::Hook::ViewListener

    # Add project.custom_start_date and project.custom_end_date fields to the projects#edit form.
    # 
    # Available context variables:
    # :project
    # :form
    def view_projects_form(context = {})
      context[:controller].send(:render_to_string, {
        :partial => "projects/form_dates",
        :locals => context
      })
    end

    # Show project.custom_start_date and project.custom_end_date in projects#show.
    # 
    # Available context variables:
    # :project
    def view_projects_show_left(context = {})
      context[:controller].send(:render_to_string, {
        :partial => "projects/show_dates",
        :locals => context
      })
    end

  end
end
