module TimeRemainingHelper
  def time_until_to_next_shuffle
    shuffle_time = Time.zone.today.beginning_of_day + 5.hours
    shuffle_time += 24.hours if Time.zone.now >= shuffle_time

    tag.time(datetime: shuffle_time) do
      "5am UTC (In about #{distance_of_time_in_words(Time.zone.now, shuffle_time)})"
    end
  end
end
