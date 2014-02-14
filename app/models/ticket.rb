class Ticket < ActiveRecord::Base
  attr_accessible :activation, :company, :computer_num, :email, :existing_os, :interesting_brand, :interesting_product, :name, :office_version, :phone, :title, :updating, :working
  serialize :existing_os, Array
  serialize :interesting_brand, Array
  serialize :interesting_product, Array
  serialize :office_version, Array
end
