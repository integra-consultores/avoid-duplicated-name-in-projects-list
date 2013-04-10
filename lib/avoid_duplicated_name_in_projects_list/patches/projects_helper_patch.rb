module AvoidDuplicatedNameInProjectsList
  module Patches
    module ProjectsHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :render_project_hierarchy, :non_visible_ancestors_as_text
        end
      end
    
      module InstanceMethods
        def render_project_hierarchy_with_non_visible_ancestors_as_text(projects)
          projects = projects.map{ |p| p.ancestors | [p] }.flatten.uniq
          render_project_nested_lists(projects) do |project|
            s = project.visible? ? 
                  link_to_project(project, {}, :class => "#{project.css_classes} #{User.current.member_of?(project) ? 'my-project' : nil}") :
                  content_tag('span', textilizable(project, :name), :class => "#{project.css_classes}")
            if project.description.present?
              s << content_tag('div', textilizable(project.short_description, :project => project), :class => 'wiki description')
            end
            s
          end
        end
      end
    end
  end  
end

unless ProjectsHelper.included_modules.include? AvoidDuplicatedNameInProjectsList::Patches::ProjectsHelperPatch
  ProjectsHelper.send(:include, AvoidDuplicatedNameInProjectsList::Patches::ProjectsHelperPatch)
end
