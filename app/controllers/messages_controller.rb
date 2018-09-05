class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!

    @message_resp = response_jared(@message.conversation_id, @message.body, @conversation.recipient_id)

    @path = conversation_path(@conversation)
  end

  def response_jared(conversation, body, recipient_id)
    client = ApiAiRuby::Client.new(
        :client_access_token => '71f0c6e4d04047ec81eb3990c3db446a'
    )

    response = client.text_request "#{body}"

    respon = response[:result][:fulfillment][:speech]

    message = Message.new
    message.body = respon
    message.user_id = recipient_id
    message.conversation_id = conversation
    message.save

    return message
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
