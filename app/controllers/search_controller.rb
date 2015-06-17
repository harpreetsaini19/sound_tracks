class SearchController < ApplicationController

  rescue_from Lastfm::ApiError, :with => :record_not_found

  before_filter :set_artist, only: [:index]

  def index
    @search = Search.new
    if @artist
      @artist_info = lastfm.artist.get_info(artist: @artist)
      @artist_top_tracks = lastfm.artist.get_top_tracks(artist: @artist)
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
    search = current_user.searches.where(artist_name: @artist).first_or_initialize
    search.updated_at = Time.current
    search.save
  end

  def set_artist
    if params[:search] && params[:search][:artist_name].present?
      @artist = params[:search][:artist_name]
    end
  end
end
