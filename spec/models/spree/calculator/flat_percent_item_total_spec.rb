require 'spec_helper'

describe Spree::Calculator::FlatPercentItemTotal do
  let(:calculator) { Spree::Calculator::FlatPercentItemTotal.new }
  let(:line_item) { build(:line_item, price: 10, quantity: 1) }

  before { calculator.stub :preferred_flat_percent => 10 }

  it "should compute amount correctly for a single line item" do
    calculator.compute(line_item).should == 1.0
  end

  context "extends LocalizedNumber" do
    it_behaves_like "a model using the LocalizedNumber module", [:preferred_flat_percent]
  end
end
