# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).oficials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phonenumber(phone_number)
  if phone_number.length < 10
    'Please respond with a valid phonenumber so we can add it to our newsletter'
  elsif phone_number.length == 11
    if phone_number[0] == '1'
      phone_number[1..10].tr(' (),.-', '')
    else
      'Please respond with a valid phonenumber so we can add it to our newsletter'
    end
  else
    phone_number.tr(' (),.-', '')
  end
end

def peak_times(reg_date, peak_hours, peak_days)
  time = Time.strptime(reg_date, '%m/%d/%y %H:%M')
  hours = time.strftime('%I %p')
  days = time.strftime('%A')

  peak_hours[hours] = peak_hours[hours].nil? ? 1 : peak_hours[hours] += 1
  peak_days[days] = peak_days[days].nil? ? 1 : peak_days[days] += 1
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'Event Manager Initialized!'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

peak_hours = {}
peak_days = {}
contents.each do |row|
  id = row[0]
  name = row[:first_name]

  peak_times(row[:regdate], peak_hours, peak_days)

  phone_number = clean_phonenumber(row[:homephone])
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end
puts "Best hours and days for ads:\nBetween:"
peak_hours.each { |k, v| puts k if v == peak_hours.values.max }
print 'On '
peak_days.each { |k, v| puts "#{k}s" if v == peak_days.values.max }
