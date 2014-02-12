class Signup < ActiveRecord::Base
  attr_accessible :company, :email, :having_pc, :name, :office_interested, :office_version, :pc_interested, :pc_os, :reason, :tel, :title, :update_need
end
