class SearchController < ApplicationController

  rescue_from Lastfm::ApiError, :with => :record_not_found

  def index
    if params[:artist].present?
      @artist_info = lastfm.artist.get_info(artist: params[:artist])
      @artist_top_tracks = lastfm.artist.get_top_tracks(artist: params[:artist])
      add_search_entry
    end
    @searches = current_user.searches.order(updated_at: :desc).limit(20).pluck(:artist_name)
  end

  private

  def record_not_found
    @error = I18n.t 'lastfm.record_not_found'
    redirect_to root_url, alert: @error
  end

  def add_search_entry
    search = current_user.searches.where(artist_name: params[:artist]).first_or_initialize
    search.updated_at = Time.current
    search.save
  end
end
