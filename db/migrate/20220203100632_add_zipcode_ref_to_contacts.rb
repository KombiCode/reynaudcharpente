class AddZipcodeRefToContacts < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :contacts, :zipcode, index: {algorithm: :concurrently}
  end
end
