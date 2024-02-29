class VotesController < ApplicationController
  before_action :require_user!
  before_action :set_votable

  def create
    @votable.votes.create(user: current_user)
    update_view
  end

  def destroy
    vote = @votable.votes.find_by(user: current_user)
    vote&.destroy
    update_view
  end

  private

  def set_votable
    @votable = find_votable
  end

  def find_votable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def update_view
    render turbo_stream: turbo_stream.replace(
      helpers.dom_id(@votable, :vote), partial: "votes/vote", locals: {votable: @votable}
    )
  end
end
