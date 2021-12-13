class VideoConversionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "video_conversion_#{params[:id]}"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
