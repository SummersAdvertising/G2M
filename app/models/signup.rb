class Signup < ActiveRecord::Base
  attr_accessible :record_id, :company, :email, :having_pc, :name, :office_version, :pc_os, :tel, :title, :update_need, :industry, :having_mobile_device, :bring_pc_to_work, :company_mobile_device
  validates :company, :email, :having_pc, :name, :office_version, :pc_os, :tel, :title, :update_need, :industry, :having_mobile_device, :bring_pc_to_work, :company_mobile_device, :presence => true

  belongs_to :record
end
