@wip
Feature: Split field

  Scenario: A single field can be split into multiple fields
    Given a "products.csv" data file containing:
    """
    id,name,category
    JNI-123,Just a product name,Main category > Subcategory > Sub-subcategory > Ultra-subcategory
    CDI-234,Another product name,Smart Insight > Cool stuff | 3dim > 2dim > 1dim
    """
    And the following definition:
    """
    source :products do
      field :id, String
      field :name, String
      field :category, String
    end

    source :transformed_products do
      field :item, String
      field :title, String
      field :main_category, String
      field :sub_category, String
      field :department, String
    end

    transform :products => :transformed_products do |record|
      record.split_field! :category, into: [:category], by: "|"
      record.split_field! :category, into: [:main_category, :sub_category, :department], by: ">"
    end
    """
    When I execute the definition
    Then there is a "transformed_products.csv" data file containing:
    """
    item,title,category1,category2,category3
    JNI-123,Just a product name,Main category,Subcategory,Sub-subcategory
    CDI-234,Another product name,Smart Insight,Cool stuff,Cool stuff
    """