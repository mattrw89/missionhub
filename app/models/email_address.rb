class EmailAddress < ActiveRecord::Base
  belongs_to :person
  validates_presence_of :person_id, :email, :on => :create, :message => "can't be blank"
  
  before_validation :set_primary, :on => :create
  after_destroy :set_new_primary
  
  def to_s
    email
  end
  protected
  
  def set_primary
    if person
      self.primary = person.primary_email_address ? false : true
    end
    true
  end
  
  def merge(other)
    EmailAddress.transaction do
      if other.primary? && other.updated_at > updated_at
        person.email_addresses.collect {|e| e.update_attribute(:primary, false)}
        new_primary = person.email_addresses.detect {|e| e.email == other.email}
        new_primary.update_attribute(:primary, true) if new_primary
      end
      MergeAudit.create!(:mergeable => self, :merge_looser => other)
      other.destroy
    end
  end
  
  def set_new_primary
    if self.primary?
      if person && person.email_addresses.present?
        person.email_addresses.first.update_attribute(:primary, true)
      end
    end
    true
  end
end
