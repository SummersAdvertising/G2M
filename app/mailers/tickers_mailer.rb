# encoding: utf-8
class TickersMailer < ActionMailer::Base
  default from: "\"夏天廣告測試信箱\" <adword@summers.com.tw>"
  
  def new_ticket( ticket )
    	@ticket = ticket
    	mail( :to => ['yuzhe.c85@gmail.com'], :subject => "[title] subject" ) do | format |
    		format.html {  }
    	end
    end
  
end
