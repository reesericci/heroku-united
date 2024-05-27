class TriggersController < ApplicationController
  def index
    Member.establish_connection
    Broadcast.establish_connection

    grouped_keys = Trigger.all.keys.group_by { |t| t.to_s.split("_").first }

    @triggers = grouped_keys.each { |k| k.second.map! { |s| Trigger.all[s] } }
  end
end
