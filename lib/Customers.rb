require_relative 'util'

class Customers

  # noinspection ALL
  class Customer

    attr_reader :id, :object, :date_created, :email_address, :first_name, :last_name, :mobile_country_code, :mobile_number, :object_reference_id

    def initialize(options = {})
      @id = get_arg(options, 'id')
      @object = get_arg(options, 'object')
      @date_created = get_arg(options, 'date_created')
      @email_address = get_arg(options, 'email_address')
      @first_name = get_arg(options, 'first_name')
      @last_name = get_arg(options, 'last_name')
      @mobile_country_code = get_arg(options, 'mobile_country_code')
      @mobile_number = get_arg(options, 'mobile_number')
      @object_reference_id = get_arg(options, 'object_reference_id')
    end

  end

  def Customers.add(options={})
    method = 'POST'
    url = '/customers'
    parameters = {}
    required_args = {}
    Array[:object_reference_id, :mobile_number, :email_address, :first_name, :last_name].each do |key|
      required_args.store(key,'False')
    end
    options.each do |key, value|
      parameters.store(key,value)
      required_args[key] = 'True'
    end
    Array[:object_reference_id, :mobile_number, :email_address, :first_name, :last_name].each do |key|
      if required_args[key] == 'False'
        raise "ERROR: #{key} is a required argument for Customers.add"
      end
    end
    parameters.each do |key, _|
      unless Array[:object_reference_id, :mobile_number, :email_address, :first_name, :last_name, :mobile_country_code].include?(key)
        puts " #{key} is an invalid argument for Customers.add"
      end
    end
    response = request(method,url,options)
    customers = Customer.new(response.body)
    return customers
  end

  def Customers.list(options={})
    method = 'GET'
    url = '/customers'
    parameters = {}
    offset = get_arg(options,:offset)
    count = get_arg(options,:count)

    if count == NIL and offset == NIL
          puts "count & offset can be passed if required.\n"
    end
    puts "count #{count}"
    puts "offset #{offset}"
    if count
      parameters.store(:count, count)
    end

    if offset
      parameters.store(:offset, offset)
    end

    options.each do |key, _|
      unless Array[:count, :offset].include?(key)
        puts " #{key} is an invalid argument for Customers.list"
      end
    end

    required_args = {}
    puts parameters
    response = Array(request(method,url,parameters).body['list'])
    customers = []
    i=0
    while i != response.count
      customer = Customer.new(response[i])
      customers.push(customer)
      i+=1
    end
    return customers
  end

  def Customers.delete(options={})
    raise "ERROR: Not Implemented"
  end

end