require 'bundler'
Bundler.require
require_relative '../lib/models/user.rb'
require_relative '../lib/models/company.rb'
require_relative '../lib/models/favorite.rb'
require_relative '../lib/CLI/command_line.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: '../db/development.db')
ActiveRecord::Base.logger = nil

# require_all 'lib'

