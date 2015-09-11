module RatesReader
  def self.read_rates(rates_xml_path)
    rates_xml = Nokogiri::XML(File.open(rates_xml_path))

    rates_nodes = rates_xml.xpath("//rates/rate")

    rates = rates_nodes.map do |node|
      node.children.map {|b| [b.name, b.text.strip] if b.elem?}.compact
    end

    results = rates.inject([]) do |sum, rate|
      sum << Rate.parse_from_result(rate)
    end

    results
  end
end