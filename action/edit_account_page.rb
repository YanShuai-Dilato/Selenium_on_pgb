

# operations at page /people/edit

require 'yaml'
require "../tools/edit_account_dialog"

class EditAccountPage
	include EditAccountDialog

	def delete_my_account
		delete_my_account_btn.click
		yes_delete_my_account_btn.click
	end
end