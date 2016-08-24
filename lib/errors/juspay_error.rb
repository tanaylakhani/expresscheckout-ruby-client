class JuspayError < StandardError
  
  def initialize(message=nil, http_status=nil, json_body=nil)
    @_message = message
    @http_status = http_status
    @json_body = json_body
  end

  def to_s
    status_string = @http_status.nil? ? '' : "(Status #{@http_status})\n"
    json_string = @json_body.nil? ? '' : "(Response #{@json_body})\n"
    "\n#{status_string}#{json_string}#{@_message}\n"
  end
end
