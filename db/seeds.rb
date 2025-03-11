# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# spreadsheet = Roo::Spreadsheet.open("./db/uploads/badevco.xlsx")

# (2..spreadsheet.last_row).each do |row|
#     # coop = Cooperative.find_or_initialize_by(name: spreadsheet.cell(row, 'A'))
#     # puts "#{coop.name}" if coop.save!

#     m = Member.find_or_initialize_by(vote_code: spreadsheet.cell(row, 'B'))
#     m.event_id = 1
#     m.name = spreadsheet.cell(row, 'A')
#     m.description = spreadsheet.cell(row, 'C')
#     # m.vote_power = 0
#     puts "#{m.name}" if m.save!

# end

# for i in 1..50
#     mem = Member.find_or_initialize_by(name: FFaker::NamePH.name)
# code = SecureRandom.alphanumeric(4).upcase
#     modified_string = code.gsub(/[1iO0I]/, "A")
#     mem.vote_code = modified_string
#     mem.event_id = 1
#     puts "#{mem.name}" if mem.save!
# end

# spreadsheet = Roo::Spreadsheet.open("./db/uploads/cofc_manila_names.xlsx")
# (2..spreadsheet.last_row).each do |row|
#   event = Event.find_by(active: 1)
#   mem = Member.find_or_initialize_by(name: spreadsheet.cell(row, "B"), event: event)
#   mem.event = event
#   mem.name = spreadsheet.cell(row, "B")
#   # mem.description = spreadsheet.cell(row, "C")
#   # mem.vote_code = spreadsheet.cell(row, "C")
#   loop do
#     code = SecureRandom.alphanumeric(4).upcase
#     modified_string = code.gsub(/[1iO0I]/, "A")
#     if Member.exists?(vote_code: modified_string)
#       puts "Code #{modified_string} already exists, generating new code..."
#     else
#       mem.vote_code = modified_string
#       break
#     end
#   end
#   # code = SecureRandom.alphanumeric(4).upcase
#   # modified_string = code.gsub(/[1iO0I]/, "A")
#   # mem.vote_code = modified_string
#   puts "#{mem.name}" if mem.save!
# end

# spreadsheet = Roo::Spreadsheet.open("./db/uploads/st_vincent_register.xlsx")
# (2..spreadsheet.last_row).each do |row|
#   mem = Member.find_by(name: spreadsheet.cell(row, "C"))
#   if mem.present?
#     mem.area = spreadsheet.cell(row, "D")
#     puts "#{mem.name}" if mem.save!
#   end
# end

# SEED FFAKER MEMBERS
# event = Event.find_by(active: 1)
# vote_code = 1001

# 10.times do
#   member = Member.create!(
#     name: FFaker::Name.name,
#     event: event,
#     voted: 0,
#     vote_code: vote_code,
#   )
#   puts "#{member.name} has been created!"
#   vote_code += 1
# end

# # SEED FFAKER CANDIDATE
# event = Event.find_by(active: 1)
# event.positions.each do |e|
#   3.times do
#     c = Candidate.create!(
#       name: FFaker::Name.name,
#       event: event,
#       position_id: 6,
#     )
#     puts "#{c.name} has been created!"
#   end
# end
