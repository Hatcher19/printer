class AddTrialEndDateToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :trial_end_date, :date
  end
end
