require 'line/bot'
class LineBotController < ApplicationController
  protect_from_forgery except: :callback
  def callback
    body = request.raw_post
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request and return
    end
    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    }
    render plain: "OK"
  end
  private 
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials[:LINE_CHANNEL_SECRET]
      config.channel_token = Rails.application.credentials[:LINE_CHANNEL_TOKEN]
    }
  end
end
