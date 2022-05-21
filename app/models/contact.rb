class Contact < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_one :contact, class_name: 'User', primary_key: :contact_id, foreign_key: :id

  def find_by_user_id(user_id)
    Contact.where(user_id: user_id)
  end
end
