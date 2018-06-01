class Role < ApplicationRecord
  has_many :users
  has_many :privileges


  def is_admin
    self.title == 'ADMIN'
  end

  def self.non_admin
    Role.where.not(title: 'ADMIN')
  end

  def self.admin
    Role.where(title: 'ADMIN')
  end
end
