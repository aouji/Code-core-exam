class AddResolverIdToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :resolver_id, :integer
  end
end
