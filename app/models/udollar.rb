class Udollar < ApplicationRecord

  default_scope { order("id desc") }
  def self.balance
    first ? first.balance : 0
  end
end
