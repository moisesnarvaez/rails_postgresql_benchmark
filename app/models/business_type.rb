# == Schema Information
#
# Table name: business_types
#
#  id          :uuid             not null, primary key
#  label       :string
#  business_id :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class BusinessType < ApplicationRecord
  belongs_to :business
end
