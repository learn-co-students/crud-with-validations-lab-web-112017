class Song < ActiveRecord::Base
  validates :title, :artist_name, presence: true
  validates :title, :release_year, uniqueness: true
  validates :release_year, presence: true, if: Proc.new { |song| song.released }
  validate :release_year_not_in_future

  def release_year_not_in_future
    if release_year.to_i > 2017
      errors.add(:release_year, "can't be in the future")
    end
  end
end
