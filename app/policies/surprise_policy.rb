class SurprisePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

  end

  def show?
      user.id == @surprise.user_id
    end

  def surprise_details?
    user

  end

  def initiate_prod_cookie?
    true
  end
end
