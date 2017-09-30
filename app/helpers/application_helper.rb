module ApplicationHelper
  def json_object_tag(content, id)
    json = content.to_json
    %(<script type="application/json" id="#{id}">#{json}</script>).html_safe
  end
end
