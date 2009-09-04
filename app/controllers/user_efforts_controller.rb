class UserEffortsController < ApplicationController
unloadable

  def index
    @active_effort = UserEffort.find(:first, :conditions => {:user_id => User.current.id})
    @issues = Issue.find(:all, :conditions => {:assigned_to_id => User.current.id}, :order => "project_id")
    
    @issued_projects = Hash.new("")
    @issues.each do |issue|  
      if !@issued_projects.has_key?(issue.project_id)
        @issued_projects[issue.project_id] = Project.find(issue.project_id).to_s
      end
    end

    @hours_stock = Hash.new(0)
    @issues.each do |issue|
      @hours_stock[issue.id] = TimeEntry.find(:all, :conditions => {:issue_id => issue.id, :user_id => User.current.id}).inject(0) do |issue_labor, te|
        issue_labor+te.hours 
      end
    end
    
  end

  def new
    if UserEffort.find(:first, :conditions => {:user_id => User.current.id}).nil?
      new_effort = UserEffort.new({:issue_id => params[:issue_id].to_i})
      new_effort.save
    else
      flash[:error] = l(:error_already_working)
    end
    redirect_to :back #:action => "index"
  end
  
  def stop
    @effort = UserEffort.find(:first, :conditions => {:user_id => User.current.id})
    @issue = Issue.find_by_id(@effort.issue_id)
    @project = @issue.project 

    @allowed_statuses = @issue.new_statuses_allowed_to(User.current)
    @edit_allowed = User.current.allowed_to?(:edit_issues, @project)
    @priorities = Enumeration::get_values('IPRI')
    @time_entry = TimeEntry.new

    @effort.destroy
  end

protected
  def clean_obsolete(except)
    UserEffort.find(:all, :conditions => {:user_id => User.current.id}).each do |effort|
      if effort != except
        effort.destroy
      end
    end
  end

 
end
