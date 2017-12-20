class CreatePapers < ActiveRecord::Migration[5.1]
  def change
    create_table :papers do |t|
      t.belongs_to :user
      t.belongs_to :cert

      t.datetime :pay_at
      t.datetime :printout_at
      t.datetime :deliver_at
      t.datetime :receive_at
      t.datetime :rate_at

      t.string :paid_code, index: true
      t.datetime :paid_code_at
      t.boolean :request_by_code
      t.string :aasm_state
      t.text :settings
      t.timestamps
    end
  end
end
