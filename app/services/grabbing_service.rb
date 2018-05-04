class GrabbingService
  def initialize(params)
    @page_url = params[:page]
    # You coud add more tags into this Array.
    @tags = %w{h1 h2 h3 h4 p span b li}
    @payload = Hash.new{|hsh,key| hsh[key] = [] }
  end

  def get_tags
    @page = HTTParty.get(@page_url)
    @dom = Nokogiri::HTML(@page)
    # Find tags and push them into the Payload.
    @tags.each do |tag|
      @dom.xpath("//#{tag}").map { |obj| @payload[tag].push(obj.text) }
    end
  end

  def create_wrapper
    @wrapper = Wrapper.new(url: @page_url, tags: @payload)
    # Is object is saved and persisted return the object itself.
    # Else return the object errors as json.
    @wrapper.save ? @wrapper : @wrapper.errors.to_json 
  end
  
  def perform
    get_tags
    create_wrapper
  end
end
