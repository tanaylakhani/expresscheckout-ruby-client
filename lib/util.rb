require_relative 'expresscheckout'

def request(method,url,parameters={})
  if $environment == 'production'
    $server = 'https://api.juspay.in'
  elsif $environment == 'staging'
    $server = 'https://sandbox.juspay.in'
  else
    raise 'ERROR: environment variable can be "production" or "staging"'
  end
  if method == 'GET'
    response = Unirest.get $server+url, headers: $version, auth:{:user=>$api_key, :password=>''}, parameters: parameters
  else
    response = Unirest.post $server +url, headers: $version, auth:{:user=>$api_key, :password=>''}, parameters: parameters
  end
  response
end

def get_arg(options = {}, param)
  if options == NIL
    NIL
  elsif options.key?(param)
    options[param]
  else
    NIL
  end
end

def check_param(options = {}, param)
  options.each do |key,_|
    if key.include?(param)
      return true
    end
  end
  false
end