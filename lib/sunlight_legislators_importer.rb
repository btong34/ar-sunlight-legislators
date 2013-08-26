require 'csv'
require_relative '../app/models/senator'
require_relative '../app/models/representative'

class SunlightLegislatorsImporter
  Representative.transaction do
    Senator.transaction do
      def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
        csv = CSV.new(File.open(filename), :headers => true)
        csv.each do |row|
          keep_fields = ['firstname', 'lastname', 'party', 'state', 'district',
                         'in_office', 'gender', 'phone', 'fax', 'website', 
                         'webform', 'twitter_id', 'birthdate']
          
          attribute_hash = row.to_hash.select { |field, value| keep_fields.include?(field) }
          if row[0] == "Rep"
            representative = Representative.create!(attribute_hash)
          else 
            senator = Senator.create!(attribute_hash)
          end
        end
      end
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end



 # t.string :first_name
 #      t.string :last_name
 #      t.string :party
 #      t.string :state
 #      t.integer :district
 #      t.integer :in_office
 #      t.string :gender
 #      t.string :phone
 #      t.string :fax
 #      t.string :website
 #      t.string :webform
 #      t.string :twitter_id
 #      t.date :birthdate