# Espeo Additional Project Settings

### A redmine plugin by Espeo Software.

Adds a couple of additional settings-columns to your project's settings, which you can edit in `projects#edit` view.

The additional settings are:

* project's start date
* project's end date
* project's status [planned, during, done, closed]
* project's deal type [fixed price, time material, mixed]
* project's image (icon)

### Requirements

* installed [File & Image Custom Fields plugin](https://github.com/espeo/redmine_file_image_custom_field)

### Installation

1. Make sure your redmine installation already meets the above *requirements*.

2. Copy this plugin's contents or check out this repository into `/redmine/plugins/espeo_additional_project_settings` directory.

3. Run `bundle exec rake redmine:plugins:migrate`.
