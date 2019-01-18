require 'open_food_network/enterprise_injection_data'

module InjectionHelper
  def inject_enterprises(enterprises = Enterprise.activated.includes(address: :state).all)
    inject_json_ams(
      'enterprises',
      enterprises,
      Api::EnterpriseSerializer,
      enterprise_injection_data
    )
  end

  def inject_enterprise_and_relatives
    inject_json_ams "enterprises", current_distributor.relatives_including_self.activated.includes(address: :state).all, Api::EnterpriseSerializer, enterprise_injection_data
  end

  def inject_group_enterprises
    inject_json_ams "group_enterprises", @group.enterprises.activated.all, Api::EnterpriseSerializer, enterprise_injection_data
  end

  def inject_current_hub
    inject_json_ams "currentHub", current_distributor, Api::EnterpriseSerializer, enterprise_injection_data
  end

  def inject_current_order
    inject_json_ams "currentOrder", current_order, Api::CurrentOrderSerializer, current_distributor: current_distributor, current_order_cycle: current_order_cycle
  end

  def inject_available_shipping_methods
    inject_json_ams "shippingMethods", available_shipping_methods,
      Api::ShippingMethodSerializer, current_order: current_order
  end

  def inject_available_payment_methods
    inject_json_ams "paymentMethods", available_payment_methods,
      Api::PaymentMethodSerializer, current_order: current_order
  end

  def inject_taxons
    inject_json_ams "taxons", Spree::Taxon.all, Api::TaxonSerializer
  end

  def inject_properties
    inject_json_ams "properties", Spree::Property.all, Api::PropertySerializer
  end

  def inject_currency_config
    inject_json_ams "currencyConfig", {}, Api::CurrencyConfigSerializer
  end

  def inject_spree_api_key
    render partial: "json/injection_ams", locals: {name: 'spreeApiKey', json: "'#{@spree_api_key.to_s}'"}
  end

  def inject_available_countries
    inject_json_ams "availableCountries", available_countries, Api::CountrySerializer
  end

  def inject_enterprise_attributes
    render partial: "json/injection_ams", locals: {name: 'enterpriseAttributes', json: "#{@enterprise_attributes.to_json}"}
  end

  def inject_orders
    inject_json_ams "orders", @orders.all, Api::OrderSerializer
  end

  def inject_shops
    customers = spree_current_user.customers.of_regular_shops
    shops = Enterprise.where(id: @orders.pluck(:distributor_id).uniq | customers.pluck(:enterprise_id))
    inject_json_ams "shops", shops.all, Api::ShopForOrdersSerializer
  end

  def inject_saved_credit_cards
    data = if spree_current_user
             spree_current_user.credit_cards.with_payment_profile.all
           else
             []
           end

    inject_json_ams "savedCreditCards", data, Api::CreditCardSerializer
  end

  def inject_json(name, partial, opts = {})
    render partial: "json/injection", locals: {name: name, partial: partial}.merge(opts)
  end

  def inject_json_ams(name, data, serializer, opts = {})
    if data.is_a?(Array)
      opts = { each_serializer: serializer }.merge(opts)
      serializer = ActiveModel::ArraySerializer
    end

    serializer_instance = serializer.new(data, opts)
    json = serializer_instance.to_json
    render partial: "json/injection_ams", locals: {name: name, json: json}
  end


  private

  def enterprise_injection_data
    @enterprise_injection_data ||= OpenFoodNetwork::EnterpriseInjectionData.new
    {data: @enterprise_injection_data}
  end
end
