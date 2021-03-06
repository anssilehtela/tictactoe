# frozen_string_literal: true

class Mylogger
  def initialize(log_name)
    @facility = "log/#{log_name}.log"
  end

  def log(text)
    open(@facility, 'a') { |k| k.puts text }
  end
end
