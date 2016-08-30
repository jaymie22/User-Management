class UsersController < ApplicationController

	before_action :get_users, only: [:show, :edit, :update, :destroy]

	def index
		@users = Users.all
	end
	
	def create
		user = Users.create( user_params )
		user.errors.any? ? flash[:error] = user.errors.full_messages : flash[:success] = 'Add user successfully!'
	
		redirect_to '/new'
	end

	def update
		if request.patch?
			@users.update_attributes( user_params )
			@users.errors.any? ? flash[:error] = @users.errors.full_messages : flash[:success] = 'Update User successfully!'	
		end

		redirect_to '/users/'+@users.id.to_s+'/edit'
	end

	def destroy
		if request.delete?
			@users.destroy
			redirect_to '/'
		end
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password)
		end
		def get_users
			@users = Users.find_by_id(params[:id])
		end
	end



