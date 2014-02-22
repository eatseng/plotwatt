class Meter < ActiveRecord::Base
  validates :a_on, :heat_ac, :refrig, :dryer, :cooking, :other, :time, :presence => true


  MONTH = {1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr", 5 => "May", 6 => "Jun",
              7 => "Jul", 8 => "Aug", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec"
            }

  def self.monthly(year)
    monthly = []
    (1..12).each do |n|
      if n == 2
	beginning = year.to_s + "-0" + n.to_s + "-01"
        ending = year.to_s + "-0" + n.to_s + "-28"
      elsif n == 1 || n == 3 || n == 5 || n = 7 || n == 8
        beginning = year.to_s + "-0" + n.to_s + "-01"
        ending = year.to_s + "-0" + n.to_s + "-31"
      elsif n == 4 || n == 6 || n == 9
	beginning = year.to_s + "-0" + n.to_s + "-01"
        ending = year.to_s + "-0" + n.to_s + "-30"
      elsif n == 10 || n == 12
        beginning = year.to_s + "-" + n.to_s + "-01"
        ending = year.to_s + "-" + n.to_s + "-31"
      else
	beginning = year.to_s + "-" + n.to_s + "-01"
        ending = year.to_s + "-" + n.to_s + "-30"
      end
      monthly[n] = Meter.where(time: beginning..ending)
    end
    parse_data(monthly)
  end


  def self.parse_data(monthly)
    data = {}
    data[:month] = []
    data[:a_on], data[:heat_ac], data[:refrig] = [], [], []
    data[:dryer], data[:cooking], data[:other] = [], [], []
    monthly.each_with_index do |monthly_data, i|
      next if monthly_data.nil?
      data[:month] << MONTH[i]
      sum = Hash.new(0)
      monthly_data.each do |record|
        sum[0] += record.a_on.to_f
        sum[1] += record.heat_ac.to_f
        sum[2] += record.refrig.to_f
        sum[3] += record.dryer.to_f
        sum[4] += record.cooking.to_f
        sum[5] += record.other.to_f
      end
      data[:a_on] << sum[0].round(2)
      data[:heat_ac] << sum[1].round(2)
      data[:refrig] << sum[2].round(2)
      data[:dryer] << sum[3].round(2)
      data[:cooking] << sum[4].round(2)
      data[:other] << sum[5].round(2)
    end
    data
  end
end
