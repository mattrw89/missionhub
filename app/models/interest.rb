class Interest < ActiveRecord::Base
  set_table_name 'mh_interest'
  belongs_to :person
  validates_presence_of :person_id, :name, :provider, :interest_id, :category, :on => :create, :message => "can't be blank"
end
