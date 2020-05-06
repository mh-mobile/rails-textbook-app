# frozen_string_literal: true

module ReportDecorator
  def report_action_tags(current_user)
    if current_user == self.user
      [
          link_to(t("shared.links.show"), self, class: ["button", "is-primary", "is-light"]),
          link_to(t("shared.links.edit"), edit_report_path(self), class: ["button", "is-link", "is-light"]),
          link_to(t("shared.links.destroy"), self, method: :delete, data: { confirm: t("reports.index.delete_confirmation") }, class: ["button", "is-danger", "is-light"])
      ]
    else
      [
          link_to(t("shared.links.show"), self, class: ["button", "is-primary", "is-light"])
      ]
    end
  end

  def learning_date_string
    learning_date.strftime("%Y-%m-%d")
  end
end
