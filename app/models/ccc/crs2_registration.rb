class Ccc::Crs2Registration < ActiveRecord::Base
  set_table_name 'crs2_registration'
  has_many :crs2_registrants, :class_name => 'Ccc::Crs2Registrant'
  has_many :crs2_registrants, :class_name => 'Ccc::Crs2Registrant'
  belongs_to :crs2_user, :class_name => 'Ccc::Crs2User', :foreign_key => :creator_id
  has_many :crs2_transactions, :class_name => 'Ccc::Crs2Transaction'
end
