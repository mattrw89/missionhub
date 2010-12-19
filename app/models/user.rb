class User < ActiveRecord::Base
  set_table_name 'simplesecuritymanager_user'
  set_primary_key 'userID'
  
  has_one :person
  has_many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me, :password
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    user = nil
    authentication = nil
    if authentication = Authentication.find_by_provider_and_uid(access_token['provider'], access_token['uid'])
      authentication.update_attribute(:token, access_token['credentials']['token'])
      user = authentication.user
    else
      user = signed_in_resource || User.find_by_email(data['email']) || User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
      authentication = user.authentications.create(:provider => 'facebook', :uid => access_token['uid'], :token => access_token['credentials']['token'])
    end
    if user.person 
      user.person.update_from_facebook(data, authentication)
    else
      user.person = Person.create_from_facebook(data, authentication)
    end
    user.save
    user
  end 
end