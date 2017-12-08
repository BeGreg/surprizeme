class SurprisePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def surprise_details?
    user
  end
end
