class XDR::Union
  include ActiveModel::Model
  include ActiveModel::AttributeMethods
  extend XDR::DSL::Union

  validates_with XDR::UnionValidator
end