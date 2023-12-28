class ClubDecorator
  def initialize(club)
    @club = club
  end

  def homebase
    "#{@club.hometown}, #{@club.country}"
  end
  
  def display_name
    @club.name
  end

  def display_homebase
    "Homebase: #{@club.homebase}"
  end

  def display_established_on
    "Established on: #{@club.established_on}"
  end

  def display_manager
    "Manager: #{@club.manager}"
  end

  def display_results
    "Results: #{last_year}: #{total_result_on(last_year)}, #{this_year}: #{total_result_on(this_year)}"
  end

  def display_players_average_age
    "Players Average Age: #{average_player_age}"
  end

  private

  def this_year
    Date.current.year
  end

  def last_year
    Date.current.year - 1
  end
  
  def total_result_on(year=nil)
    year = Date.current.year unless year

    matches = @club.matches_on(year).count
    won = @club.win_on(year)
    lost = @club.lost_on(year)
    draw = @club.draw_on(year)

    "matches: #{matches} won: #{won} lost: #{lost} draw: #{draw}"
  end

  def average_player_age
    @club.average_player_age.to_f.round(1)
  end
  
end
