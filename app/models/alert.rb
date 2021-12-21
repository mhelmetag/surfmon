# frozen_string_literal: true

# == Schema Information
#
# Table name: alerts
#
#  id         :integer          not null, primary key
#  name       :string
#  conditions :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Alert < ApplicationRecord
end
