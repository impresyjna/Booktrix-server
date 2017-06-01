require 'spec_helper'

RSpec.describe Category, type: :model do
  before {@category = FactoryGirl.build(:category)}

  subject {@category}

  it { should respond_to(:name) }
  it { should respond_to(:color) }
  it { should respond_to(:font_color) }

  it { should be_valid }

  it { should validate_presence_of(:name) }

  it { should belong_to(:user) }

end
