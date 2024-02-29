module ApplicationHelper
  def vote_path_for(votable, vote = nil)
    votable_type = votable.class.name.downcase
    action = vote.nil? ? :create : :destroy

    if action == :destroy
      send(:"#{votable_type}_vote_path", "#{votable_type}_id": votable.id, id: vote.id)
    else
      send(:"#{votable_type}_vote_path", "#{votable_type}_id": votable.id)
    end
  end
end
