# Including dispatcher.rb in case of Rails 2.x
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    # use require_dependency if you plan to utilize development mode
    require_dependency 'avoid_duplicated_name_in_projects_list/patches/projects_helper_patch'
    require_dependency 'avoid_duplicated_name_in_projects_list/hooks/base_layout_hooks'
  end
else
  Dispatcher.to_prepare BW_AssetHelpers::PLUGIN_NAME do
    # use require_dependency if you plan to utilize development mode
    require_dependency 'avoid_duplicated_name_in_projects_list/patches/projects_helper_patch'
    require_dependency 'avoid_duplicated_name_in_projects_list/hooks/base_layout_hooks'
  end
end

Redmine::Plugin.register :avoid_duplicated_name_in_projects_list do
  name 'Avoid Duplicated Name In Projects List plugin'
  author 'Integra Consultores'
  description 'It modify the project list view by showing ancestors (as text, no link) of visible projects. It allows to distinguish between subprojects of different roots but with the same name.'
  version '0.0.1'
  url 'https://github.com/integra-consultores/avoid-duplicated-name-in-projects-list'
  author_url 'https://github.com/integra-consultores'
end
