require 'csv'

class Parser
  def self.parse(filepath)
    parser_data = CSV.open(filepath, headers: true, header_converters: :symbol)
  end
end
