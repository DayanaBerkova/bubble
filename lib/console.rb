class Console
  def Console.output(output_data)
    Console.sleep_and_clear if output_data.is_a? Array
    puts output_data
  end

  def Console.outprint(outprint_data)
    print outprint_data
  end

  def Console.input
    get_character.chr.to_i
  end

  def Console.sleep_and_clear
    sleep(0.2)
    system 'cls'
  end
end