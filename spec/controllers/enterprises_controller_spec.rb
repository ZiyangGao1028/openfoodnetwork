require 'spec_helper'
require 'spree/core/current_order'

describe EnterprisesController do
  include Spree::Core::CurrentOrder

  before :each do
    stub!(:before_save_new_order)
    stub!(:after_save_new_order)

    create(:itemwise_shipping_method)
  end

  it "displays suppliers" do
    s = create(:supplier_enterprise)
    d = create(:distributor_enterprise)

    spree_get :suppliers

    assigns(:suppliers).should == [s]
  end
end
