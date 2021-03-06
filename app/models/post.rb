class Post < ApplicationRecord
  mount_uploader :image, ImageUploader # для добовления картинок
  validates :title, :summary, :body, presence: true #проверка на не пустое значение
  has_many :comments
  belongs_to :user
  belongs_to :category

end
