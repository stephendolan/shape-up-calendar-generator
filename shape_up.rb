require 'icalendar'
require 'date'

# Define the start date for the first Shape Up cycle
year = Time.now.year
first_day_of_year = Date.new(year, 1, 1)
first_monday_of_year = first_day_of_year + (8 - first_day_of_year.wday) % 7
start_date = first_monday_of_year

# Define the duration of each cycle
build_cycle_duration = 6 # weeks
cooldown_cycle_duration = 2 # weeks
cycle_duration = (build_cycle_duration + cooldown_cycle_duration) * 7 # days

# Define the calendar events for the Shape Up cycles
6.times do |i|
  cycle_number = i + 1

  build_cycle_start_date = start_date
  build_cycle_end_date = build_cycle_start_date + 6 * 7 - 2 # 6 weeks, omit last weekend

  cooldown_cycle_start_date = build_cycle_end_date + 2 # omit last weekend
  cooldown_cycle_end_date = cooldown_cycle_start_date + 2 * 7 - 2 # 2 weeks, omit last weekend

  build_cycle_event = Icalendar::Event.new
  build_cycle_event.dtstart = build_cycle_start_date
  build_cycle_event.dtend = build_cycle_end_date
  build_cycle_event.summary = "Shape Up - Cycle #{cycle_number} Build"
  build_cycle_event.description = "This is the Cycle #{cycle_number} build phase from #{build_cycle_start_date} to #{build_cycle_end_date}."

  cooldown_cycle_event = Icalendar::Event.new
  cooldown_cycle_event.dtstart = cooldown_cycle_start_date
  cooldown_cycle_event.dtend = cooldown_cycle_end_date
  cooldown_cycle_event.summary = "Shape Up - Cycle #{cycle_number} Cooldown"
  cooldown_cycle_event.description = "This is the Cycle #{cycle_number} cooldown phase from #{cooldown_cycle_start_date} to #{cooldown_cycle_end_date}."

  # Generate the ICS file for the build phase
  build_cal = Icalendar::Calendar.new
  build_cal.add_event(build_cycle_event)
  File.open("shape_up_cycle_#{cycle_number}_build.ics", 'w') { |f| f.write(build_cal.to_ical) }

  # Generate the ICS file for the cooldown phase
  cooldown_cal = Icalendar::Calendar.new
  cooldown_cal.add_event(cooldown_cycle_event)
  File.open("shape_up_cycle_#{cycle_number}_cooldown.ics", 'w') { |f| f.write(cooldown_cal.to_ical) }


  start_date += cycle_duration # Set the start date for the next cycle
end
