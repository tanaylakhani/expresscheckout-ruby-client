class JuspayError < StandardError
  attr_reader :message
  attr_reader :http_status
  attr_reader :json_body

  def initialize(message=nil, http_status=nil, json_body=nil)
    @_message = message
    @http_status = http_status
    @json_body = json_body
  end

  def message
    status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
    json_string = @json_body.nil? ? "" : "(Request #{@json_body}) "
    print "Json :"+json_string
    print "status : "+status_string
    "#{status_string}\n#{json_string}\n#{@_message}"
  end
end
