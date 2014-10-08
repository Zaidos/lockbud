require 'sinatra'
require 'slim'
require 'serialport'

port_str = ENV['USB_PORT']
baud_rate = ENV['BAUD_RATE']
data_bits = ENV['DATA_BITS']
stop_bits = ENV['STOP_BITS']
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
    serial = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    serial.write('o')
    serial.close
    slim :success
  else
    @flash = "Incorrect passcode. Try again."
    slim :index
  end
end
