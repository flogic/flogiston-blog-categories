class Category < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name, :allow_blank => true
  
  has_many :categorizations
  has_many :articles, :through => :categorizations
end
