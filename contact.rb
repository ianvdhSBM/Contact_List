require 'pry'
require 'pg'
require 'active_record'

# Represents a person in an address book.
class Contact < ActiveRecord::Base

    validates :email, uniqueness: true, presence: true
    validates :name, presence: true

end



