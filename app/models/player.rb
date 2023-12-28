class Player < ApplicationRecord
  belongs_to :club

  def age
    ((Time.zone.now  - birthday.to_time) / 1.year.seconds).floor
  end

  def self.average_age
    average("EXTRACT(YEAR FROM AGE(birthday))").to_f
  end
end
