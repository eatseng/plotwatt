require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :import_data => :environment do

    csv_file_path = 'db/plotwatt_appliance_data.csv'

    first_row = true
    CSV.foreach(csv_file_path) do |row|
      unless first_row
        Meter.create!({
          :a_on => row[0],
          :heat_ac => row[1],
          :refrig => row[2],
          :dryer => row[3],
          :cooking => row[4],
          :other => row[5],
          :time => row[6],
        })
      end
      first_row = false  
    end
  end
end