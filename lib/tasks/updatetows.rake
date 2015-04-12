namespace :updatedb do
  desc "Populate newest tows from API"
  task updatetows: :environment do
    last_tow = Tow.last["TowNum"] if Tow.last
    last_tow ||= 305800
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?$where=townum%20>%20'
    full_url = base_url + "\'" + last_tow.to_s + "\'" + "&$limit=5000"
    todays_tows = JSON.parse(open(full_url).read)
    todays_tows.each do |x|
      t = Tow.new
      t.TowNum = x["townum"]
      t.Tow_Firm = x["tow_firm"]
      t.Tow_Firm_Address = x["tow_firm_address"]
      t.Tow_Firm_Phone = x["tow_firm_phone"]
      t.Vehicle_State = x["vehicle_state"]
      t.Vehicle_Plate = x["vehicle_plate"]
      t.Vehicle_Year = x["vehicle_year"]
      t.Make = x["make"]
      t.Model = x["model"]
      t.Color = x["color"]
      t.Tow_From_Address = x["tow_from_address"].squish!
      t.Date = Date.strptime(x["date"], '%m%d%Y')
      t.Time = Time.strptime(x["date"]+x["time"], '%m%d%Y%H%M')
      t.geom = x["geom"]["longitude"] + "," + x["geom"]["latitude"] if x["geom"]
      t.save
    end
  end

  desc "Compare the tows to the users, and send appropriate alerts."
  task compare :environment do
    User.joins(:tows).each do |user|
      user.alert("it worked")
    end
  end

  desc "Check for cars picked up by owner."
  task removetows: :environment do
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?$select=townum&$limit=5000'
    website_tows_array = JSON.parse(open(base_url).read)
    current_tows = Array.new
    website_tows_array.each { |i| current_tows << i["townum"].to_i }
    Tow.where(removed_at: nil).find_each do |tow|
      unless current_tows.include?(tow.TowNum)
        tow.removed_at = Time.now 
        tow.save
      end
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