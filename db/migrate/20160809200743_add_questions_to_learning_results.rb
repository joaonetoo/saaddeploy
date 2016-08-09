class AddQuestionsToLearningResults < ActiveRecord::Migration
  def change
    add_column :learning_results, :q1a, :integer
    add_column :learning_results, :q1b, :integer
    add_column :learning_results, :q1c, :integer
    add_column :learning_results, :q1d, :integer

    add_column :learning_results, :q2a, :integer
    add_column :learning_results, :q2b, :integer
    add_column :learning_results, :q2c, :integer
    add_column :learning_results, :q2d, :integer

    add_column :learning_results, :q3a, :integer
    add_column :learning_results, :q3b, :integer
    add_column :learning_results, :q3c, :integer
    add_column :learning_results, :q3d, :integer

    add_column :learning_results, :q4a, :integer
    add_column :learning_results, :q4b, :integer
    add_column :learning_results, :q4c, :integer
    add_column :learning_results, :q4d, :integer

    add_column :learning_results, :q5a, :integer
    add_column :learning_results, :q5b, :integer
    add_column :learning_results, :q5c, :integer
    add_column :learning_results, :q5d, :integer

    add_column :learning_results, :q6a, :integer
    add_column :learning_results, :q6b, :integer
    add_column :learning_results, :q6c, :integer
    add_column :learning_results, :q6d, :integer

    add_column :learning_results, :q7a, :integer
    add_column :learning_results, :q7b, :integer
    add_column :learning_results, :q7c, :integer
    add_column :learning_results, :q7d, :integer

    add_column :learning_results, :q8a, :integer
    add_column :learning_results, :q8b, :integer
    add_column :learning_results, :q8c, :integer
    add_column :learning_results, :q8d, :integer

    add_column :learning_results, :q9a, :integer
    add_column :learning_results, :q9b, :integer
    add_column :learning_results, :q9c, :integer
    add_column :learning_results, :q9d, :integer

    add_column :learning_results, :q10a, :integer
    add_column :learning_results, :q10b, :integer
    add_column :learning_results, :q10c, :integer
    add_column :learning_results, :q10d, :integer

    add_column :learning_results, :q11a, :integer
    add_column :learning_results, :q11b, :integer
    add_column :learning_results, :q11c, :integer
    add_column :learning_results, :q11d, :integer

    add_column :learning_results, :q12a, :integer
    add_column :learning_results, :q12b, :integer
    add_column :learning_results, :q12c, :integer
    add_column :learning_results, :q12d, :integer
  end
end
