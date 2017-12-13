class CreatePapers < ActiveRecord::Migration[5.1]
  def change
    create_table :papers do |t|
      t.belongs_to :user
      t.belongs_to :cert
      t.string :aasm_state
      t.text :settings
      t.timestamps
    end
  end
end
