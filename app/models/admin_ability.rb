class AdminAbility
  
  include CanCan::Ability

  def initialize(admin)
    if admin
      can :access, :rails_admin
      can :manage

      can :index, User         # included in :read
      can :new, User           # included in :create
      can :show, User
           # for HistoryIndex
      can :destroy, User       # for BulkDelete

      can :index, Entry         # included in :read
      can :show, Entry
      # can :edit, Entry
      can :export, Entry
      can :destroy, Entry       # for BulkDelete

      can :index, Client 
      can :new, Client        # included in :read
      can :show, Client
      # can :edit, Entry
      can :export, Client
      can :destroy, Client       # for BulkDelete

      can :index, Admin         # included in :read
      can :show, Admin
      can :new, Admin           # included in :create
           # for HistoryIndex
      can :destroy, Admin       # for BulkDelete
    end
  end
end