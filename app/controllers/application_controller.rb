class ApplicationController < ActionController::Base
    include Pagy::Backend
    @my_event = Event.find_by(active: 1)
end
