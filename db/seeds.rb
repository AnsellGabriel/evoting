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

for i in 1..50
    mem = Member.find_or_initialize_by(name: FFaker::NamePH.name)
    code = SecureRandom.alphanumeric(4).upcase
    modified_string = code.gsub(/[1iO0I]/, "A")
    mem.vote_code = modified_string
    mem.event_id = 1
    puts "#{mem.name}" if mem.save!
end