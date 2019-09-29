class Movie < ActiveRecord::Base
  def self.getRatings()
    ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings)
    if(ratings)  
        Movie.where(rating: ratings)
    else
        Movie.all
    end    
  end
end
