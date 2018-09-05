class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
      @users = User.where(id: 1)
      @conversations = Conversation.involving(current_user).order("created_at DESC")
  end
end
