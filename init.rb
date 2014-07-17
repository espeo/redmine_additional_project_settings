require 'espeo_additional_project_settings/patches/project_patch'
require 'espeo_additional_project_settings/hooks'

Redmine::Plugin.register :espeo_additional_project_settings do
  name 'Espeo Additional Project Settings plugin'
  author 'espeo@jtom.me'
  description 'Adds a couple of additional settings-columns to your project\'s model, editable in projects#edit.'
  version '1.0.0'
  url 'http://espeo.pl'
  author_url 'http://jtom.me'
end
