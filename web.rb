require 'sinatra'
require 'slim'
require 'serialport'

port_str = ENV['USB_PORT']
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

configure do
  enable :logging
  set :app_file, __FILE__
  set :slim, :pretty => true
end

get '/' do
  slim :index
end

post '/' do
  if params[:passcode] == ENV['PASSCODE']
    SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity) do |serial|
      serial.write('o')
    end
    slim :success
  else
    @flash = "Incorrect passcode. Try again."
    slim :index
  end
end
