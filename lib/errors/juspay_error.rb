class JuspayError < StandardError
  
  def initialize(message=nil, http_status=nil, json_body=nil)
    @message = message
    @http_status = http_status
    @json_body = json_body
  end

  def to_s
    status_string = @http_status.nil? ? '' : "(Status #{@http_status}) "
    json_string = @json_body.nil? ? '' : "(Request #{@json_body}) "
    "#{status_string}\n#{json_string}\n#{@message}"
  end
end
