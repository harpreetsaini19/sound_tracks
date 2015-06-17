module SearchHelper

  def classify(artist_info)
    artist = {}
    artist[:name]      = artist_info['name']
    artist[:summary]   = artist_info['bio']['summary'].present? ? artist_info['bio']['summary'] : ""
    artist[:url]       = artist_info['url']
    artist[:stats]     = { listeners: artist_info['stats']['listeners'], playcount: artist_info['stats']['playcount'] }
    artist[:image]     = artist_info['image'][3].present? ? artist_info['image'][3]['content'] : ""
    artist[:tags]      = artist_info['tags'].present? && artist_info['tags']['tag'].any? ? artist_info['tags']['tag'].map{ |i| { name: i['name'], url: i['url'] } } : []
    artist[:published] = artist_info['bio']['published'].present? ? artist_info['bio']['published'].to_date.strftime('%d %b, %Y') : ""

    similar = []
    if artist_info['similar'].present? && artist_info['similar']['artist'].any?
      similar = artist_info['similar']['artist'].map{ |i| { name: i['name'], image: i['image'][1]['content']  } }
    end

    return artist, similar
  end

  def artist_profile(artist)
    content_tag :div, class: "artist-profile", align: "left" do
      artist_image =  (content_tag :div, class: "pull-left" do
                        artist_image(artist[:image]) + published_at(artist[:published])
                      end).to_s
      tags         =  (content_tag :div do
                        artist_tags(artist[:tags])
                      end).to_s
      name_header  =  (content_tag :div do
                        artist_name(artist[:name], artist[:url]) + stats(artist[:stats])
                      end).to_s
      summary      =  (content_tag :div do
                        artist_summary(artist[:summary]).to_s
                      end).to_s
      artist_bio = name_header + summary + tags
      (artist_image + artist_bio).html_safe
    end
  end

  def similar_artists(similar)
    content_tag :div, class: "similar-artists" do
      similar.map{|i| similar_artist(i).to_s}.join(' ').html_safe
    end
  end

  def artist_top_tracks(top_tracks)
    top_tracks = [top_tracks] unless top_tracks.is_a?(Array)
    content_tag :div, class: "top-tracks", align: "left" do
      ((content_tag(:h3){ "Top Tracks" }).to_s + " " +
      (content_tag(:br){}).to_s +
      top_tracks.map{|i| top_track(i).to_s}.join(" ").html_safe)
    end
  end

  def recent_searches(searches)
    searches.map{|i| (link_to i, { controller: "search", action: "index", search: {artist_name: i}}).to_s }.join("<br/>").html_safe
  end

  private

  def artist_image(image)
    image_tag image, class: "artist-image"
  end

  def artist_tags(tags)
    content_tag :div, class: "tags" do
      tags.map{ |i| link_to( (content_tag(:span, class: "badge"){ i[:name] } ), i[:url] ).to_s }.join(' ').html_safe
    end
  end

  def artist_name(name, url)
    content_tag :h4, class: "artist-name" do
      link_to(name, url)
    end
  end

  def stats(stats)
    content_tag :div, class: "artist-stats" do
      (content_tag :span, class: "label label-warning" do
        (content_tag(:i, class: "fa fa-play"){}).to_s + " " + stats[:playcount]
      end).to_s + " " +
      (content_tag :span, class: "label label-warning" do
        (content_tag(:i, class: "fa fa-headphones"){}).to_s + " " + stats[:listeners]
      end).to_s
    end
  end

  def published_at(date)
    if date.present?
      content_tag :span, class: "label label-info published-at" do
        (content_tag(:i, class: "fa fa-calendar"){}).to_s + " " + date
      end
    end
  end

  def artist_summary(summary)
    content_tag :p, class: "small summary" do
      summary.html_safe
    end
  end

  def similar_artist(artist)
    link_to (content_tag :div, class: "similar-artist pull-left" do
                (image_tag artist[:image], class: "similar-artist-image").to_s +
                (content_tag :div do
                  artist[:name]
                end).to_s
              end).to_s, { controller: "search", action: "index", search: {artist_name: artist[:name]}}
  end

  def top_track(track)
    content_tag :div, class: "top-track" do
      (link_to track['name'], track['url'], class: "pull-left").to_s + 
      (content_tag :div, class: "pull-right" do
        (duration(track['duration']).to_s + " " +
        stats({ playcount: track['playcount'], listeners: track['listeners'] }).to_s).html_safe
      end).to_s
    end
  end

  def duration(duration_in_sec)
    if duration_in_sec.is_a?(String)
      content_tag :div, class: "duration" do
        (content_tag :span, class: "label label-info" do
          (content_tag(:i, class: "fa fa-clock-o"){}).to_s + " " + Time.zone.at(duration_in_sec.to_i).utc.strftime("%M:%S")
        end).to_s
      end
    end
  end
end
