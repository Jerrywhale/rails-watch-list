class Movie < ApplicationRecord
  has_many :bookmarks
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true

  private

  # Méthode pour vérifier la présence de Bookmarks avant de détruire un Movie

  def check_for_bookmarks
    if bookmarks.exists?
      raise ActiveRecord::InvalidForeignKey, "Cannot destroy movie with associated bookmarks"
    end
  end
end
