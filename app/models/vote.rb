class Vote < ActiveRecord::Base
belongs_to :voteable, polymorphic: true
belongs_to :user
belongs_to :post
validates_uniqueness_of :user, scope: :voteable
end