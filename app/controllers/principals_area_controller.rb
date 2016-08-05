class PrincipalsAreaController < ApplicationController
  def index
    @videos = current_user.sent_videos
  end

  def create_video
  end

  def list
  end

  def my_events
    @events = Event.where(:user_id => current_user.id)
  end

  def search_anchors
  end

  def search_plans
  end

  def send_video
  end

  def show_plan
  end

  def videos_index
  end
end
