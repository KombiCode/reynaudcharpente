class Message < ApplicationRecord
  belongs_to :contact

  enum project_schedule: { asap: "asap", begin: "begin", midterm: "midterm" }
end
