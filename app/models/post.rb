class Post < ApplicationRecord
  validates :title, :summary, :body, presence: true #проверка на не пустое значение

end
