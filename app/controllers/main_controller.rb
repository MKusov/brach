class MainController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      current_user.first_name.nil? ? (redirect_to '/edit_profile') : (redirect_to '/chat_rooms')
    end
  end

  def user_profile
    @user = User.find_by_id(current_user.id)
  end

  def user_profile_edit
    @user = User.find_by_id(current_user.id)
    @user.update_attributes(profile_params)
    redirect_to '/chat_rooms'
  end

  def chat_room_delete
    id = params[:id]
    chat_room = ChatRoom.find_by_id(id)
    if current_user.admin? || current_user.id == chat_room.user_id
      chat_room.destroy
    end
    redirect_to :back
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :country, :city, :avatar)
  end
end
