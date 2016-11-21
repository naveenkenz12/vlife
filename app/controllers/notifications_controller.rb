class NotificationsController < ApplicationController
	before_action :logged_in_user , only: [:notify]

	def notify
		@ntf = NotifyTo.where(:to_id => current_user.u_id, :status => 'N').pluck(:not_id, :from_id, :to_id)
		puts @ntf
		@notification = []
		for @u in @ntf
			@notification.push(Notification.select(:eve_id, :p_id, :slam_id, :page_id, :content).find_by(:not_id => @u[0]))
		end
		@notification = @notification.zip(@ntf)
		NotifyTo.where(:to_id => current_user.u_id, :status => 'N').update_all(:status => 'S')
		
		msg = {:status => "ok", :value => @notification}
		render :json => msg
	end
end