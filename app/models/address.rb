class Address < ActiveRecord::Base
  
  scope :sorted, lambda { order("addresses.created_at ASC") }
  
  def self.allowable?(email)
    allowable = false
    Address.all.each do |a|
      if a.email == email
        return allowable = true
      end
    end
    allowable
  end
  
  def not_duplicate
    not_duplicate = true
    Address.all.each do |a|
      not_duplicate = false if a.email == self.email
    end
    not_duplicate
  end
  
end
