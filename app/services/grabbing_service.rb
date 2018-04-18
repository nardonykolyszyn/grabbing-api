class GrabbingService
  def initialize(params)
    @page_url = params[:page]
    @tags = %w{h1 h2 h3}
    @payload = Hash.new{|hsh,key| hsh[key] = [] }
  end

  def get_tags
    @page = HTTParty.get(@page_url)
    @dom = Nokogiri::HTML(@page)
    @tags.each do |tag|
      @dom.xpath("//#{tag}").map { |obj| @payload[tag].push(obj.text) }
    end
  end

  def create_wrapper
    @wrapper = Wrapper.new(url: @page_url, tags: @payload)
    @wrapper.save ? @wrapper : @wrapper.errors.to_json 
  end
  
  def perform
    get_tags
    create_wrapper
  end
end
