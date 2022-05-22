class Api::V1::MessagesController < ActionController::API
  def show
    begin
      current_second = Time.now.to_i
      Rails.cache.write("user_last_request_#{params[:id]}", current_second)

      10.times do
        if params[:last_message_id].present?
          @messages = Message.where('id > ?', params[:last_message_id])
                             .and(
                               Message.where(source_user_id: params[:id]).or(Message.where(target_user_id: params[:id]))
                             )
                             .limit(2)
        else
          @messages = Message.where(source_user_id: params[:id])
                             .or(Message.where(target_user_id: params[:id]))
                             .limit(2)
        end

        unless @messages.empty?
          break
        end

        sleep 0.2
      end
    end

    render json: @messages
  end

  # POST /messages
  def create
    message = Message.new(message_params)
    message.save

    render json: { success: true, message: message }
  end

  private
  def message_params
    params.require(:message).permit(:source_user_id, :target_user_id, :message_content)
  end
end
