class Event < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  validate :time_is_in_future

  def time_is_in_future
    if time < Time.now
      errors.add(:time, "must be in the future")
    end
  end
end
