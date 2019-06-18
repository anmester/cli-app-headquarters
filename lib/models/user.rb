class User < ActiveRecord::Base
    has_many :favorites
    has_many :companies, through: :favorites
end