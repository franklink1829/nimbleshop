class ProductGroup < ActiveRecord::Base

  has_many :product_group_conditions, extend: SearchExtension

  accepts_nested_attributes_for :product_group_conditions, allow_destroy: true

  include BuildPermalink


  validates :name, presence: true

  # determines if the given product exists in the product group
  def exists?(product)
    products.include?(product)
  end

  def self.fields
    c = []
    c << { "id" => 'name', "name" => 'Name', "field_type" => 'text' }
    c << { "id" => 'price', "name" => 'Price', "field_type" => 'number' }

    CustomField.all.map do | field |
      c << field.attributes.slice("id", "name", "field_type")
    end

    c
  end

  def self.operators
    {
      text: [{ name: 'Contains', value: 'contains'}, {name: 'Starts With', value: 'starts'}, { name: 'Ends With', value:'ends'}],
      number: [{ name: 'Equal', value: 'eq'}, {name: 'Greater Than', value: 'gt'}, { name: 'Grater Than Equal To', value:'gteq'}, {name: 'Less Than', value: 'lt'}, {name: 'Less Than Equal To', value: 'lteq'}],
      date: [{ name: 'On', value: 'eq'}, {name: 'After', value: 'gt'}, { name: 'On or After', value:'gteq'}, {name: 'Before', value: 'lt'}, {name: 'On or Before', value: 'lteq'}],
    }
  end

  def products
    product_group_conditions.search
  end


  def summarize
    product_group_conditions.map(&:summary).join('  and ')
  end

   # list of all product groups containing input product
  def self.contains_product(product)
    self.all.select do |pg|
      pg.exists?(product)
    end
  end
end
