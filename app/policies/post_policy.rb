class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        scope.all
      else
        scope.where(status: :published)
      end
    end
  end

  def index?
    can_see?
  end

  def show?
    can_see?
  end

  def new?
    can_create?
  end

  def create?
    can_create?
  end

  def edit?
    can_edit?
  end

  def update?
    can_edit?
  end

  def destroy?
    can_edit?
  end

  def render_html?
    can_see?
  end

  def republish?
    can_edit?
  end

  #---------------------------------------------------

  def can_see?
    true
  end

  def can_create?
    user.present?
  end

  def can_edit?
    can_create? and (record.user.id == user.id)
  end

end
