class AddDescriptionToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :description, :string
  end
end
