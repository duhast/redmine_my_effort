class UserEffort < ActiveRecord::Base
  belongs_to :user
  has_one :issue

  validates_presence_of :issue_id

  def initialize(arguments = nil)
    #Start timer
    super(arguments)
    self.start_time = DateTime.now
    self.active = true
    self.user_id = User.current.id
  end

  def hours_spent
    today = DateTime.now
    if today.hour < start_time.hour
      hours = (today.day - start_time.day - 1)*24 + today.hour + (24 - start_time.hour)
    elsif today.hour == start_time.hour+1
      hours = 0
    else
      hours = today.hour - start_time.hour
    end
    if today.min < start_time.min
      minutes = (60-start_time.min) + today.min
    else
      minutes = today.min - start_time.min
    end

    rtick = (Setting.plugin_redmine_my_effort['tick_interval']).to_i
    dh = rtick * (minutes / rtick)
    dh += rtick if minutes-dh > rtick/2

    (hours+dh/60.0).to_f
  end

end
