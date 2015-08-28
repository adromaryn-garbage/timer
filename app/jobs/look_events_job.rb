class LookEventsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    loop do
      Event.all.each do |event|
        if event.time <= Time.now do
          event.delete
        end
      end
    end
  end
end
