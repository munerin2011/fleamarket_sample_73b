class RemoveBirthMonthFromProfile < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :birth_month, :date
  end
end
