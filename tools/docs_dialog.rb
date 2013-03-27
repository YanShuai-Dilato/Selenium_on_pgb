
module DocsDialog
	def documentation() 
		@documentation ||= @data[:docs][:documentation]	
	end
end