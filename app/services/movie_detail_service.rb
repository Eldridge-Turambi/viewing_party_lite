# frozen_string_literal: true

class MovieDetailService < ApiService
  class << self
    def find_movie(movie_id)
      response = connection.get("movie/#{movie_id}")
      data = parse_json(response)
    end
  end
end
