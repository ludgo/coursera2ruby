class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists, source: :todo_items, dependent: :destroy

  validates :username, presence: true

  def get_completed_count
  	count = 0
  	TodoList.where( user_id: id ).find_each do |todo_list|
  		count += TodoItem.where( todo_list_id: todo_list.id, completed: true ).count
  	end
  	return count
  end
  
end
