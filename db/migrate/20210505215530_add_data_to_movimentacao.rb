class AddDataToMovimentacao < ActiveRecord::Migration[6.1]
  def change
    add_column :movimentacaos, :data, :datetime, null: false, precision: 6
  end
end
