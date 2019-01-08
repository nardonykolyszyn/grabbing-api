# frozen_string_literal: true

require 'singleton'

class GrabbingService
  include Singleton

  TAGS = %w[h1 h2 h3 h4 h5 p span b li strong].freeze

  def get_tags
    @page = HTTParty.get(@page_url)
    @dom = Nokogiri::HTML(@page)
    # Find tags and push them into the Payload.
    build_payload
    TAGS.each do |tag|
      @dom.xpath("//#{tag}").map { |obj| @payload[tag].push(obj.text.strip) }
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

  private

  def build_payload
    @payload ||= Hash.new { |h, k| h[k] = [] }
  end
end
