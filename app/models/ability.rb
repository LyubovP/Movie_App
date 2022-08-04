# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :manage, ActiveAdmin::Page, :name => "Dashboard"
    else
      can :read, :all
      can :manage, Review, user_id: user.id
    end
  end
end
