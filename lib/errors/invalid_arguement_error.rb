class InvalidArguementError < JuspayError
  def initialize(message=nil)
    @_message = (message ? message : "Please pass requiered parameters.")
    super(@_message)
  end
end

