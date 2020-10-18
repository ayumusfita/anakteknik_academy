autoload :JsonPath, 'jsonpath'

Given(/^user login to hit the API$/) do
  @headers = {
    'Content-Type' => 'application/json',
    'Authorization' => "Bearer #{ENV['API_ACCESS_TOKEN']}"
  }
  @path = ENV['API_BASE_URL']
end

When(/^user sends a GET request to "([^"]*)"$/) do |url|
  path = URI.encode(@path + url)
  
  options = { headers: @headers, timeout: 10 }
  response = HTTParty.get(path, options)
  @response_raw = response unless response.nil?
  body = response.body

  @response = JSON&.parse(response.body) unless body.nil?
  @response_code = response.code
  puts "Response body: #{@response.to_json}"
end

When(/^user sends a POST request to "([^"]*)" with body:$/) do |url, body|
  path = URI.encode(@path + url)
  options = { headers: @headers, timeout: 10, body: body}

  response = HTTParty.post(path, options)
  @response_raw = response unless response.nil?
  body = response.body

  @response = JSON&.parse(response.body) unless body.nil?
  @response_code = response.code
  puts "Response body: #{@response.to_json}"
end

Then(/^response should have "([^"]*)"$/) do |json_path|
  json_path = APIHelper.resolve_variable(self, json_path)
  results = JsonPath.new(json_path).on(@response).to_a
  expect(results).send("not_to", be_empty)
end

Then(/^response status should be "([^"]*)"$/) do |status|
  error_codes = {
    'OK' => 200,
    'Created' => 201,
    'Accepted' => 202,
    'Not Found' => 404,
    'Bad Request' => 400,
    'Unauthorized' => 401,
    'Unprocessable Entity' => 422,
    'Internal Server Error' => 500
  }
  expect(@response_code).to eq(error_codes[status] || status.to_i)
end

Then(/^response "([^"]*)" should be (integer|string|boolean|float|array)$/) do |json_path, datatype|
  data = JsonPath.new(json_path).on(@response).first
  case datatype
  when 'integer'
    expect(data).to be_kind_of Integer
  when 'string'
    expect(data).to be_kind_of String
  when 'boolean'
    expect(data).to be(true).or be(false)
  when 'float'
    expect(data).to be_kind_of Float
  when 'array'
    expect(data).to be_kind_of Array
  end
end

Then(/^response should have "([^"]*)" matching "([^"]*)"$/) do |json_path, value|
  json_path = APIHelper.resolve_variable(self, json_path)
  results = JsonPath.new(json_path).on(@response).to_a.map(&:to_s)
  expect(results).send("to", include(APIHelper.resolve_variable(self, value, /\{\{([a-zA-Z0-9_]+)\}\}/)))
end
