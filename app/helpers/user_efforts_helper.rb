module UserEffortsHelper

  def activity_collection_for_select_options
    activities = Enumeration::get_values('ACTI')
    collection = []
    collection << [ "--- #{l(:actionview_instancetag_blank_option)} ---", '' ] unless activities.detect(&:is_default)
    activities.each { |a| collection << [a.name, a.id] }
    collection
  end

end
