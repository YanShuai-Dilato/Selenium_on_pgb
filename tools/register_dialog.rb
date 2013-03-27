
module RegisterDialog
	def free_plan_link()  
		@free_plan_link ||= @data[:register_page][:free_plan]  
	end
	def paid_plan_link()  
		@paid_plan_link ||= @data[:register_page][:paid_plan]  
	end
	def contact_us_link() 
		@contact_us_link ||= @data[:register_page][:contact_us] 
	end
end