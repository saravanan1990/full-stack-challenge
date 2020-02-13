class CreateFounders < ActiveRecord::Migration[6.0]
  def change
    create_table :founders do |t|
      t.string :name
      t.string :title
      t.references :company

      t.timestamps
    end
  end
end
