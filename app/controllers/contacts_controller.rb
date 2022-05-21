class ContactsController < BaseAuthorizedController
  def index
    @none_friend_users = UserProfile
                           .joins("""
                            LEFT JOIN
                            (
                              select
                                sum(contact_id=#{Current.user.id} or user_id=#{Current.user.id}) as contact_count, user_id
                                from contacts group by user_id
                            ) as c ON user_profiles.user_id = c.user_id
                           """)
                           .where("(c.contact_count is null or c.contact_count = 0)")
                           .and(UserProfile.where.not(user_id: Current.user.id))
  end
end
