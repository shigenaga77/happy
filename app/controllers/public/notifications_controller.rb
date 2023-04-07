class Public::NotificationsController < ApplicationController
    def index
        @notifications = current_member.passive_notifications.all
        # page(params[:page]).per(20)
        @notifications.where(checked: false).each do |notification|
          notification.update(checked: true)
        end
    end
end
