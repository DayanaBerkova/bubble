$LOAD_PATH.unshift "../"

require 'lib/console'

class IOStream
  @@console = true
  @@gui = false
  @@test = false

  def IOStream.output(output_data)
    return Console.output(output_data) if @@console
    output_data if @@test
  end

  def IOStream.outprint(outprint_data)
    Console.outprint(outprint_data) if @@console
  end

  def IOStream.input
    return Console.input if @@console
    return File.open('input.txt').readline.to_i if @@test
  end

  def IOStream.test=(value)
    @@test = value
    @@console = false
    @@gui = false
  end

  def IOStream.console=(value)
    @@console = value
    @@test = false
    @@gui = false
  end
end
