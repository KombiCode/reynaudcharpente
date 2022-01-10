class AddProjectScheduleToMessages < ActiveRecord::Migration[7.0]
  def change
    safety_assured {
      reversible do |dir|
        dir.up do
          #add a type
          execute <<-SQL
            CREATE TYPE project_schedule AS ENUM ('asap', 'begin', 'midterm');
          SQL
          add_column :messages, :project_schedule, :project_schedule, default: 'midterm'
        end
        dir.down do
          remove_column :messages, :project_schedule
          execute <<-SQL
            DROP TYPE project_schedule;
          SQL
        end
      end
    }
  end
  # def change
  #   safety_assured {
  #     execute <<-SQL
  #       CREATE TYPE project_schedule AS ENUM ('asap', 'begin', 'midterm');
  #     SQL
  #     add_column :messages, :project_schedule, :project_schedule
  #   }
  # end
end

