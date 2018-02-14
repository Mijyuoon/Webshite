module ApplicationHelper
  def json_object_tag(data, id)
    %(<script type="application/json" id="#{id}">#{data.to_json}</script>).html_safe
  end

  def add_flash_to_frontend_data
    @frontend_data ||= {}
    @frontend_data[:alerts] = []

    flash.each do |name, data|
      data = data.map {|x| x.merge(type: name) }
      @frontend_data[:alerts] += data
    end

    nil
  end
end
