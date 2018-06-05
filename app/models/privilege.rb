class Privilege < ApplicationRecord
  belongs_to :role

  before_validation :default_values


  private

  def default_values
    self.can_access = self.can_access != nil ? self.can_access : true
  end
end
