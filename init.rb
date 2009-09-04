require 'redmine'

Redmine::Plugin.register :redmine_my_effort do
  name 'My Effort plugin'
  author 'Oleg Vivtash'
  description 'Allows to start/stop timers for time spent on an issue from a separate tab'
  version '0.1.0'

  permission :my_effort, {:user_efforts => [:index, :new, :stop]}, :require => :member
  menu :top_menu, :my_effort, { :controller => 'user_efforts', :action => 'index' }, :caption => 'My Effort'

  settings :default => {
    'tick_interval' => '30'
  }, :partial => 'settings/myeffort_settings'

end
