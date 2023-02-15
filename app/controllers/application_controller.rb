class ApplicationController < ActionController::Base
    @my_event = Event.find_by(active: 1)
end
