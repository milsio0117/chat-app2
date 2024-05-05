class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new
    @messages = @room.messages.includes(:user)  #チャットルームに紐付いている全てのメッセージ。ユーザー情報もまとめて取得
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user) #失敗したときの処理にも@messagesが定義されていないとエラーになる
      render :index, status: :unprocessable_entity
    end
  end



  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end