class Api::FriendshipsController < Api::BaseController
  def index
    @friendships = current_user.friendships
    respond_with @friendships do |format|
      format.json { render json: @friendships.to_json(only: [:id], include: { buddy: { only: [:id, :name, :last_seen], methods: [:md5email, :tracks_count, :online?] } }) }
    end
  end

  def create
    @buddy = User.find params[:buddy_id]
    current_user.buddies << @buddy
    respond_with @buddy do |format|
      format.json { render json: @buddy.to_json }
    end
  end

  def destroy
    @friendship = Friendship.find params[:id]
    @friendship.destroy
    render nothing: true
  end
end
