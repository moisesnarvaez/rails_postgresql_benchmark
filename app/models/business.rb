# == Schema Information
#
# Table name: businesses
#
#  id                   :uuid             not null, primary key
#  name                 :string
#  business_types_jsonb :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Business < ApplicationRecord
  has_many :business_types, dependent: :destroy
end
