class AddTrialUpgradedToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :trial_upgraded, :boolean
  end
end
