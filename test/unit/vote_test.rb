# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  score_id   :integer
#  user_id    :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  login      :string(255)
#

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
