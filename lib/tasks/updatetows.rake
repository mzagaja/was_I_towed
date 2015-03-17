namespace :updatedb do
  desc "Populate newest tows from API"
  task updatetows: :environment do
    today = "03012015"
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?Date='
    full_url = base_url + today
    todays_tows = JSON.parse(open(full_url).read)
    todays_tows.each do |x|
      t = Tow.new
      t.TowNum = x["townum"]
      t.Tow_Firm = x["tow_firm"]
      t.Tow_Firm_Address = x["tow_firm_address"]
      t.Tow_Firm_Phone = x["tow_firm_phone"]
      t.Vehicle_State = x["vehicle_state"]
      t.Vehicle_Year = x["vehicle_year"]
      t.Make = x["make"]
      t.Model = x["model"]
      t.Color = x["color"]
      t.Tow_From_Address = x["tow_from_address"].squish!
      t.Date = Date.strptime(x["date"], '%m%d%Y')
      t.Time = Time.strptime(x["date"]+x["time"], '%m%d%Y%H%M')
      t.geom = x["geom"]["longitude"] + "," + x["geom"]["latitude"]
      t.save
    end
  end
  desc "Test Dates"
  task testdates: :environment do
    today = "03012015"
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?Date='
    full_url = base_url + today
    todays_tows = JSON.parse(open(full_url).read)
    todays_tows.each do |x|
      puts Date.strptime(x["date"], '%m%d%Y')
      puts Time.strptime(x["date"]+x["time"], '%m%d%Y%H%M')
      puts x["geom"]["longitude"] + "," + x["geom"]["latitude"]
    end
  end
end