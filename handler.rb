require 'rack'

app = Proc.new do |env|
  [
    200,
    { 'Content-Type' => 'text/plain' },
    ["Welcome aboard!\n"]
  ]
end

Rack::Hadler::WEBrick.run app
