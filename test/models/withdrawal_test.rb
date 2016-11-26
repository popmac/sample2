# == Schema Information
#
# Table name: withdrawals
#
#  id                    :integer          not null, primary key
#  impression_unuseful   :boolean          default(FALSE), not null
#  impression_difficult  :boolean          default(FALSE), not null
#  impression_not_enough :boolean          default(FALSE), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
