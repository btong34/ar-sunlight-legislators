require_relative '../db/config'
require_relative 'models/representative'
require_relative 'models/senator'

def senators_by_state(state)
  Senator.select('firstname', 'lastname', 'party').order('lastname').where(:state => state)
end

def reps_by_state(state)
  Representative.select('firstname', 'lastname', 'party').order('lastname').where(:state => state)
end

def sen_by_gender(gender)
  Senator.where(:gender => gender, :in_office => '1').count
end

def rep_by_gender(gender)
  Representative.where(:gender => gender, :in_office => '1').count
end

def sen_gender_percent(gender)
  ((sen_by_gender(gender) / Senator.where(:in_office => '1').count.to_f)*100).ceil
end

def rep_gender_percent(gender)
  ((rep_by_gender(gender) / Representative.where(:in_office => '1').count.to_f)*100).ceil
end

def active_sen_by_state
  Senator.where(:in_office => '1').group('state').count.sort_by { |state, count| count }.reverse
end

def active_rep_by_state
  Representative.where(:in_office => '1').group('state').count.sort_by { |state, count| count }.reverse
end

def delete_inactive
  Representative.where(:in_office => '0').destroy_all
  Senator.where(:in_office => '0').destroy_all
end

#Display Methods

def print_legs_by_state(state)
  puts "Senators:"	
  senators_by_state(state).each do |senator|
  	puts "  #{senator.firstname} #{senator.lastname} (#{senator.party})"
  end
  puts "Representatives:"
  reps_by_state(state).each do |rep|
  	puts "  #{rep.firstname} #{rep.lastname} (#{rep.party})"
  end
end


def print_gender_breakdown(gender)
  if gender == 'M'
  	complete_gender = 'Male'
  else
  	complete_gender = 'Female'
  end
  puts "#{complete_gender} Senators: #{sen_by_gender(gender)} (#{sen_gender_percent(gender)}%)"
  puts "#{complete_gender} Representatives: #{rep_by_gender(gender)} (#{rep_gender_percent(gender)}%)"
end

def print_legs_count_by_state
  active_rep_by_state.each do |state|
  	puts "#{state[0]}: #{senators_by_state(state).count} Senators, #{state[1]} Representative(s)"
  end
end

def print_total_legislators
  puts "Senators: #{Senator.count}"
  puts "Representatives: #{Representative.count}"
end



# print_legs_by_state('NY')
# p gender_percentage('M')
# print_gender_breakdown('M')
# print_gender_breakdown('F')
# print_legs_count_by_state
print_total_legislators
delete_inactive
print_total_legislators




# p count_active_rep('NY')