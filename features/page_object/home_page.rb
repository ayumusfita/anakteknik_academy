# frozen_string_literal: true

class HomePage < SitePrism::Page
  element :inventory_item_section, '.inventory_item'
  element :cart_container, '#shopping_cart_container'
end
