module MessagesHelper
  def human_attribute_project_schedules
    Hash[Message.project_schedules.map {
      |k,v| [k, I18n.t("activerecord.attributes.message/project_schedule.#{k}")]
    }]
  end
end
