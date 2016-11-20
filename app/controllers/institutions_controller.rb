class InstitutionsController < ApplicationController
	before_action :logged_in_user, only: [:new_institute]

	def new_institute
		n = params[:new_ins][:name].downcase.titleize
		c = params[:new_ins][:country].downcase.titleize
		t = params[:new_ins][:city].downcase.titleize

		s = params[:new_ins][:state]
		if !s.blank?
			s = s.downcase.titleize
		end

		i = Institution.find_by(:name => n, :country => c, :city => t)

		if !i.nil?			#if already institute present
			#check if user is already present in same institution then error
			@pui = UserInstitution.find_by(:ins_id => i.ins_id, :u_id => current_user.u_id)

			if !@pui.nil?		#already present
				@pui.start = params[:new_ins][:start]
				@pui.end = params[:new_ins][:end]
				@pui.save
				redirect_to '/'+current_user.u_id+'/about'
			else
				@nui = UserInstitution.new
				@nui.ins_id = i.ins_id
				@nui.u_id = current_user.u_id
				@nui.start = params[:new_ins][:start]
				@nui.end = params[:new_ins][:end]
				@nui.save
				redirect_to '/'+current_user.u_id+'/about'
			end
		else				#no such institution in database
			#save location if not already present
			@ol = Location.find_by(:country => c, :state => s, :city => t)
			if @ol.nil?
				@nl = Location.new
				@nl.country = c
				@nl.state = s
				@nl.city = t
				@nl.save
			end

			#first create institution
			@ins = Institution.new
			cnt = Institution.count.to_s(36)
			@ins.ins_id = cnt
			@ins.name = n
			@ins.country = c
			@ins.state = s
			@ins.city = t
			@ins.save

			#now create user_institution
			@ui = UserInstitution.new
			@ui.ins_id = cnt
			@ui.u_id = current_user.u_id
			@ui.start = params[:new_ins][:start]
			@ui.end = params[:new_ins][:end]
			@ui.save

			redirect_to '/'+current_user.u_id+'/about'
		end

	end

end