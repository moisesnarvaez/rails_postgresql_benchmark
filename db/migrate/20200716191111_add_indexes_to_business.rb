class AddIndexesToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_index :businesses, :business_types_jsonb, using: :gin
    add_index :business_types, :label
  end
end
