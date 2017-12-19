class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, exclusion: { in: [nil] }
  validates :release_year, presence: true, if: :released
  validate :future?
  validates :title, uniqueness: { scope: :release_year }

  def future?
    if release_year && release_year > Time.now.year
      errors.add(:release_year, "Song cannot be released in the future.")
    end
  end

end
