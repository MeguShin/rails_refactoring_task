# This class is for representing one row in the league table.
module Poros
  class LeagueTableRow
    attr_accessor :club, :rank, :year, :matches, :digested_games_count, :win, :lost, :draw, :goals, :goals_conceded, :goal_difference, :points

    def initialize(club, year)
      @club = club
      @year = year
      @rank = nil
      @matches = club.matches_on(year)
    end

    # def prepare_row
    #   @digested_games_count = @matches.where(kicked_off_at: Date.new(year, 1, 1)...Time.current).count
    #   @win = club.win_on(year)
    #   @lost = club.lost_on(year)
    #   @draw = club.draw_on(year)
    #   @goals = matches.sum {|match| match.goal_by(club) }
    #   @goals_conceded = matches.sum {|match| match.goal_conceded_by(club) }
    #   @goal_difference = goals - goals_conceded
    #   @points = win * League::WIN_POINTS + draw * League::DRAW_POINTS
    #   self
    # end
    def prepare_row
      self.tap do |row|
        row.digested_games_count = digested_games_count
        row.win = win
        row.lost = lost
        row.draw = draw
        row.goals = goals
        row.goals_conceded = goals_conceded
        row.goal_difference = goal_difference
        row.points = points
      end
    end
    
    def digested_games_count
      @matches.where(kicked_off_at: Date.new(year, 1, 1)...Time.current).count
    end

    def win
      club.win_on(year)
    end

    def lost
      club.lost_on(year)
    end

    def draw
      club.draw_on(year)
    end

    def goals
      @matches.sum { |match| match.goal_by(club) }
    end

    def goals_conceded
      @matches.sum { |match| match.goal_conceded_by(club) }
    end

    def goal_difference
      goals - goals_conceded
    end

    def points
      win * League::WIN_POINTS + draw * League::DRAW_POINTS
    end
  end
end
