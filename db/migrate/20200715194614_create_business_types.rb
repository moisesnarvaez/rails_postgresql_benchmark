class CreateBusinessTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :business_types, id: :uuid do |t|
      t.string :label
      t.references :business, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
