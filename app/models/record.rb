class Record < ActiveRecord::Base
  attr_accessible :answer, :fbshare_id, :user_fbid, :user_type
end
