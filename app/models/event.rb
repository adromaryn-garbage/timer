class Event < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  validate :time_is_in_future
  validates :phone_number, :phony_plausible => true,
                           presence: true

  def time_is_in_future
    if time < Time.now
      errors.add(:time, "must be in the future")
    end
  end
end
