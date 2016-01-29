class Sub < ActiveRecord::Base

  validates :title, :moderator_id, presence: true

  belongs_to(
    :moderator,
    class_name: 'User'
  )

end
