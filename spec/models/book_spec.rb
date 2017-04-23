require 'spec_helper'

RSpec.describe Book, type: :model do
  before {@book = FactoryGirl.build(:book)}

  subject {@book}

  it { should respond_to(:isbn) }
  it { should respond_to(:title) }
  it { should respond_to(:author) }
  it { should respond_to(:publisher)}

  it { should be_valid }

  it { should validate_presence_of(:isbn) }

  describe "validates isbn" do
    it { should allow_value('9788365401076').for(:isbn) }
    it { should_not allow_value('978836540107').for(:isbn) }
    it { should_not allow_value('aaa').for(:isbn) }
    it { should_not allow_value(' ').for(:isbn) }
    # it { should_not allow_value('').for(:isbn) }
    it { should allow_value('8387463477').for(:isbn) }
  end

end
