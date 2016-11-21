class Withdrawal < ActiveRecord::Base
  attr_accessor :impression
  validates :impression, present_impression: true
end
