module IssuesHelper

  def working_on_issue?(user, issue)
    !UserEffort.find(:first, :conditions => {:user_id => user.id, :issue_id => issue.id}).nil?
  end

end