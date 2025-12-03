class User
  attr_reader :name, :email, :time_zone, :color, :avatar_url, :billed,
              :role, :description, :invitation_sent, :job_title, :teams,
              :created_via_sso, :contact_methods, :notification_rules,
              :coordinated_incidents, :locale, :id, :type, :summary, :self, :html_url

  def initialize(data)
    @name = data["name"]
    @email = data["email"]
    @time_zone = data["time_zone"]
    @color = data["color"]
    @avatar_url = data["avatar_url"]
    @billed = data["billed"] || false
    @role = data["role"]
    @description = data["description"] || ""
    @invitation_sent = data["invitation_sent"] || false
    @job_title = data["job_title"] || ""
    @teams = data["teams"] || []
    @created_via_sso = data["created_via_sso"] || false
    @contact_methods = data["contact_methods"] || []
    @notification_rules = data["notification_rules"] || []
    @coordinated_incidents = data["coordinated_incidents"] || []
    @locale = data["locale"] || "en-US"
    @id = data["id"]
    @type = data["type"]
    @summary = data["summary"]
    @self = data["self"]
    @html_url = data["html_url"]
  end
end