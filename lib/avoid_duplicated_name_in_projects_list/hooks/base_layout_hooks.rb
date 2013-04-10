module AvoidDuplicatedNameInProjectsList
  module Hooks
    
    class BaseLayoutHooks < Redmine::Hook::ViewListener
      def view_layouts_base_html_head context={}
        stylesheet_link_tag 'avoid_duplicated_name_in_projects_list', :plugin => :avoid_duplicated_name_in_projects_list
      end
    end
    
  end
end