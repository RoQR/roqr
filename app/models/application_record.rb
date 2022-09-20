# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Hashid::Rails
  primary_abstract_class
end
