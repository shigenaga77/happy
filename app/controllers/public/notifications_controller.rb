class Public::NotificationsController < ApplicationController
    def index
        @main_background_image = "background-image3"
        @notifications = current_member.passive_notifications.all
        # page(params[:page]).per(20)
        @notifications.where(checked: false).each do |notification|
          notification.update(checked: true)
        end
    end
end
