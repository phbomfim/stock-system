class CreateEstoques < ActiveRecord::Migration[6.1]
  def change
    create_table :estoques do |t|
      t.references :produto, null: false, foreign_key: true
      t.references :local_armazenamento, null: false, foreign_key: true
      t.integer :quantidade

      t.timestamps
    end
  end
end
