require 'active_record'


ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contacts',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)

puts 'CONNECTED'

# ActiveRecord::Schema.define do
  
#   create_table :stores do |t|
#     t.column :name, :string
#     t.column :annual_revenue, :integer
#     t.column :mens_apparel, :boolean
#     t.column :womens_apparel, :boolean
#     t.timestamps null: false
#   end
#   create_table :employees do |table|
#     table.references :store
#     table.column :first_name, :string
#     table.column :last_name, :string
#     table.column :hourly_rate, :integer
#     table.timestamps null: false
#   end
# end