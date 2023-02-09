require_relative 'time_format'

class App
  def call(env)
    @env = env
    if @env['REQUEST_PATH'] == '/time'
      handle_time_request
    else
      send_response("Page not found\n", 404)
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def handle_time_request
    formats = take_format
    time_format = TimeFormat.new(formats)
    time_format.call
    if time_format.success?
      send_response(time_format.time_to_string, 200)
    else
      send_response(time_format.unknown_format_answer, 400)
    end
  end

  def take_format
    Rack::Utils.parse_query(@env['QUERY_STRING'])['format']
  end

  def send_response(body, status)
    Rack::Response.new(body, status, headers).finish
  end
end
