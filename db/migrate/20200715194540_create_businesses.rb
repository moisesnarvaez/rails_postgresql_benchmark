class CreateBusinesses < ActiveRecord::Migration[6.0]
  def change
    create_table :businesses, id: :uuid do |t|
      t.string :name
      t.jsonb :business_types_jsonb

      t.timestamps
    end
  end
end
