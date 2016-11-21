class NotificationsController < ApplicationController
	before_action :logged_in_user , only: [:notify]

	def notify
		@ntf = NotifyTo.where(:to_id => current_user.u_id, :status => 'N')
		@ntf.update_all(:status => 'S')
		@notification = []
		for @u in @ntf
			@notification.push(Notification.find_by(:not_id => @u.not_id).pluck(:eve_id, :p_id, :slam_id, :page_id))
		end
		@ntf = @ntf.pluck(:from_id, :to_id, )
		@ntf = @ntf.pluck(:not_id, :from_id, :to_id)
		@notification = @notification.zip(@ntf)
		msg = {:status => "ok", :value => @notification}
		render :json => msg
	end
end