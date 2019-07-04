class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :categories, :text, array: true, default: ["Limpieza", "Atención al cliente", "Seguridad", "Ubicación"]
  end
end
