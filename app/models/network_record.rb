class NetworkRecord < ApplicationRecord
  belongs_to :network_host
  belongs_to :network_name
end
