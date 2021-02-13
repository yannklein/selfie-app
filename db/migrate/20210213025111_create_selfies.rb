class CreateSelfies < ActiveRecord::Migration[6.1]
  def change
    create_table :selfies do |t|
      t.string :title

      t.timestamps
    end
  end
end
