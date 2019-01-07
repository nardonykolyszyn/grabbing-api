# frozen_string_literal: true

require 'singleton'

class GrabbingService

  include Singleton

  TAGS = %w[h1 h2 h3 h4 p span b li].freeze

  def get_tags
    @page = HTTParty.get(@page_url)
    @dom = Nokogiri::HTML(@page)
    # Find tags and push them into the Payload.
    @payload = Hash.new{ |hsh,key| hsh[key] = [] }
    TAGS.each do |tag|
      @dom.xpath("//#{tag}").map { |obj| @payload[tag].push(obj.text) }
    end
    @payload
  end

  def create_wrapper
    @wrapper = Wrapper.new(url: @page_url, tags: @payload)
    # If object is saved and persisted then return the object itself.
    # Else return the object errors as json format.
    @wrapper.save ? @wrapper : @wrapper.errors.to_json 
  end
  
  def perform(page_url)
    @page_url = page_url
    get_tags
    create_wrapper
  end
end
