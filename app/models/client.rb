class Client
  include Mongoid::Document
  field :name, :type => String
  field :adresse, :type => String
end
