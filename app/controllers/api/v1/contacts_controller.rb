class Api::V1::ContactsController < ActionController::API
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  def show
    current_second = Time.now.to_i
    Rails.cache.write("user_last_request_#{params[:id]}", current_second)

    @contacts = Contact.where(user_id: params[:id]).map do |contact|
      user_profile = contact.contact.user_profile

      contact_last_request = Rails.cache.read("user_last_request_#{contact.contact.id}")

      {
        contact_id: contact.contact.id,
        user_name: "#{user_profile.first_name} #{user_profile.last_name}",
        avatar_url: user_profile.avatar_url,
        online: contact_last_request.present? && (current_second - contact_last_request) < 4.1
      }
    end

    render json: @contacts
  end

  # POST /contacts
  def create
    new_contact_1 = Contact.new(contact_params)
    new_contact_1.save

    new_contact_2 = Contact.new({
      contact_id: contact_params[:user_id],
      user_id: contact_params[:contact_id]
    })
    new_contact_2.save

    render json: { success: true}
  end

  private
  def contact_params
    params.require(:contact).permit(:contact_id, :user_id)
  end
end
