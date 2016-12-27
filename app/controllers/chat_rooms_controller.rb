class ChatRoomsController < ApplicationController
  def index
    if user_signed_in?
      User.find_by_id(current_user.id).update_attribute(:room, 0)
      @chat_rooms = ChatRoom.all
      @chat_room = ChatRoom.new
    else
      redirect_to '/users/sign_in'
    end
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Вы создали беседу!'
      redirect_to '/chat_rooms/'+@chat_room.id.to_s
    else
      render 'new'
    end
  end

  def show
    if user_signed_in?
      query = params[:id]
      User.find_by_id(current_user.id).update_attribute(:room, query)
      @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
      redirect_to '/chat_rooms' if @chat_room.nil?
      @message = Message.new
      @user_list = User.where(room: query)
    else
      redirect_to '/'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end