
class ApplicationResource < Graphiti::Resource
    self.adapter = Graphiti::Adapters::ActiveRecord
    self.abstract_class = true
  end
  
class FakeResource < ApplicationResource; end
