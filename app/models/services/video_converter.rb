module Services
    class VideoConverter
        def intitialize(tweet_id)
            @tweet = Tweet.find(tweet_id)
        end

        def convert!
            # return unless @tweet.convert_video?
            process_video
            update_needs_conversion
        end

        private
        def process_video
            @tweet.profile_video.open(tmpdir: "/tmp") do |file|
                movie = FFMPEG::Movie.new(file.path)
                path = "tmp/video-#{SecureRandom.alphanumeric(12)}.mp4"
                movie.transcode(path, { video_codec: 'libx264', audio_codec: 'aac' })
                @tweet.profile_video.attach(io: File.open(path), filename: "video-#{SecureRandom.alphanumeric(12)}.mp4", content_type: 'video/mp4')
            end
        end

        def update_needs_conversion
            @tweet.update_column(:convert_video, false)
        end
    end
end