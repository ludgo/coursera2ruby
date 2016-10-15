class Profile < ActiveRecord::Base
  belongs_to :user

  validates :first_name, presence: true, if: "last_name.nil?"
  validates :last_name, presence: true, if: "first_name.nil?"
  validate :correct_gender, :sue_not_male

  def correct_gender
  	if gender != "male" && gender != "female"
  		errors.add(:gender, 'incorrect gender')
  	end
  end

  def sue_not_male
  	if gender == "male" && first_name == "Sue"
  		errors.add(:gender, 'Sue is not a male')
  	end
  end

  def self.get_all_profiles(min, max)
    Profile.where( birth_year: min..max ).order( :birth_year )
  end

end
