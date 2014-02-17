#encoding: utf-8
class Record < ActiveRecord::Base
  attr_accessible :answer, :fbshare_id, :user_fbid, :user_type
  validates_length_of :answer, :minimum => 18, :message => "不能空白"
  validates :user_type, :presence => true

  has_one :signup
end
