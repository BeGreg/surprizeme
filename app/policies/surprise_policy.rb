class SurprisePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
    def show?
      user.id == @surprise.user_id
    end
  end
end
