class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :comment, presence: true, length: { maximum: 30 }

  #メモ数算出
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  scope :created_2days_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3days_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4days_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5days_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6days_ago, -> { where(created_at: 6.day.ago.all_day) }
end