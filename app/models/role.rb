class Role < ApplicationRecord
  has_many :users
  has_many :privileges

  def is_intern
    self.title == 'INTERN'
  end

  def self.non_admin
    Role.where.not(title: 'ADMIN')
  end

  def self.admin
    Role.where(title: 'ADMIN').first
  end

  def self.intern
    Role.where(title: 'INTERN').first
  end

  def self.interns
    Role.where(title: 'INTERN')
  end

  def self.evaluator
    Role.where(title: 'EVALUATOR').first
  end

end
