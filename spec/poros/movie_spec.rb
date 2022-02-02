require 'rails_helper'

RSpec.describe Movie do

  it 'has attributes' do
    data = {
      movie_id: 1,
      title: "pirates",
      overview: "Story about pirates",
      vote_average: 9,
      genre: 'adventure',
      cast: ['name1', 'name2', 'name3'],
      reviews: ['review1', 'review2', 'review3']
    }

    movie = Movie.new(data)

    expect(movie).to be_a(Movie)
    expect(movie.title).to eq('pirates')
    expect(movie.id).to eq(1)
    expect(movie.genre).to eq('adventure')
  end
end
