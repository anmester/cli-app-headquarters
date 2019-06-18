class Company < ActiveRecord::Base
    self.table_name = :companies
    has_many :favorites
    has_many :users, through: :favorites
end