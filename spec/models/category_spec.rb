require 'spec_helper'

RSpec.describe Category, type: :model do
  before {@category = FactoryGirl.build(:category)}

  subject {@category}

  it { should respond_to(:name) }
  it { should respond_to(:color) }
  it { should respond_to(:font_color) }

  it { should be_valid }

  it { should validate_presence_of(:name) }

  describe "validates color" do
    it { should allow_value('#ffffff').for(:color) }
    it { should_not allow_value('ffffff').for(:color) }
    it { should_not allow_value('').for(:color) }
  end

  describe "validates font_color" do
    it { should allow_value('#ffffff').for(:font_color) }
    it { should_not allow_value('ffffff').for(:font_color) }
    it { should_not allow_value('').for(:font_color) }
  end

end
