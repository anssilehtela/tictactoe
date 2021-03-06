
class Mylogger

  def initialize(log_name)
    @facility = "log/#{log_name}.log"
  end

  def log(text)
    binding.pry
    open(@facility, 'a') { |k| k.puts text }
  end

end