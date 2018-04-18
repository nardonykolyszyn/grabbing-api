require 'rails_helper'

RSpec.describe Wrapper, :type => :model do
  it { is_expected.to validate_presence_of(:tags) }
end
