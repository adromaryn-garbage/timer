require 'smsc_api'

class LookEventsJob < ActiveJob::Base
  queue_as :default
  
  
  def perform
    sms = SMSC.new()
    loop do
      Event.all.each do |event|
      	Time.use_zone(event.timezone) do
      	  if event.time <= Time.now
      	    if ret = sms.send_sms(event.phone_number, "At #{event.time}: #{event.message}", translit = 0)
      	      event.delete
      	    end
          end
        end     
      end
    end
  end
end
