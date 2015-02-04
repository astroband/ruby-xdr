class XDR::Union
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  extend XDR::Concerns::ConvertsToXDR
  extend XDR::DSL::Union


  class_attribute :arms
  class_attribute :switches
  class_attribute :switch_type
  class_attribute :switch_name

  self.arms        = ActiveSupport::OrderedHash.new
  self.switches    = ActiveSupport::OrderedHash.new
  self.switch_type = nil
  self.switch_name = nil

  validates_with XDR::UnionValidator
end



