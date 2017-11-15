class JuspayError < StandardError
  
  def initialize(message=nil, http_status=nil, json_body=nil, request_params=nil)
    @_message = message
    @http_status = http_status
    @json_body = json_body
    @request_params = request_params
  end

  def to_s
    status_string = @http_status.nil? ? '' : "(Status #{@http_status})\n"
    json_string = @json_body.nil? ? '' : "(Response #{@json_body})\n"
    request_params = @request_params.nil? ? '' : "(Request parameters : #{@request_params})\n"
    "\n#{status_string}#{json_string}#{@_message}#{request_params}\n"
  end
end
