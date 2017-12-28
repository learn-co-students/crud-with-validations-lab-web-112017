class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, exclusion: { in: [nil] }
  validates :release_year, presence: true, if: :released
  validates :title, uniqueness: { scope: :release_year }
  validate :released?


  def released?
    if release_year && release_year > Time.now.year
      errors.add(:release_year, "Song cannot be released ahead of the current date.")
    end
  end
end
