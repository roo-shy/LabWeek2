require "erb"
require "csv"

#read
html = File.read("report.erb")

#replace

profit = []

CSV.foreach("planet_express_logs.csv", headers: true) do |row|
  profit << row.to_hash
end

revenue = profit.map {|revenue| revenue["Money"].to_i }
puts revenue.inspect

value = revenue.inject(0, :+)

puts value.inspect
puts revenue.inspect

fry = []
amy = []
bender = []
leela = []

salaries = profit.each do |salary|
   if salary["Destination"] == "Earth"
     fry << salary
   elsif salary["Destination"] == "Mars"
     amy << salary
   elsif salary["Destination"] == "Uranus"
     bender << salary
   else
     leela << salary
   end
end

earthmoney = []
marsmoney = []
uranusmoney = []
moonmoney = []
jupitermoney = []
plutomoney = []
mercurymoney = []
saturnmoney = []

moneyperplanet = profit.each do |money|
   if money ["Destination"] == "Earth"
      earthmoney << money
   elsif money ["Destination"] == "Mars"
      marsmoney << money
   elsif money ["Destination"] == "Uranus"
      uranusmoney << money
   elsif money ["Destination"] == "Moon"
      moonmoney << money
   elsif money ["Destination"] == "Jupiter"
      jupitermoney << money
   elsif money ["Destination"] == "Pluto"
      plutomoney << money
   elsif money ["Destination"] == "Mercury"
      mercurymoney << money
   elsif money ["Destination"] == "Saturn"
      saturnmoney << money
   end
end


moneyperearth = earthmoney.map {|moneyperearth| moneyperearth["Money"].to_i}.inject(:+)
moneypermars = marsmoney.map {|moneypermars| moneypermars["Money"].to_i}.inject(:+)
moneyperuranus = uranusmoney.map {|moneyperuranus| moneyperuranus["Money"].to_i}.inject(:+)
moneypermoon = moonmoney.map {|moneypermoon| moneypermoon["Money"].to_i}.inject(:+)
moneyperjupiter = jupitermoney.map {|moneyperjupiter| moneyperjupiter["Money"].to_i}.inject(:+)
moneyperpluto = plutomoney.map {|moneyperpluto| moneyperpluto["Money"].to_i}.inject(:+)
moneypermercury = mercurymoney.map {|moneypermercury| moneypermercury["Money"].to_i}.inject(:+)
moneypersaturn = saturnmoney.map {|moneypersaturn| moneypersaturn ["Money"].to_i}.inject(:+)

 frymoney= fry.map {|frymoney| frymoney["Money"].to_i}.inject(:+)
 amymoney= amy.map {|amymoney| amymoney["Money"].to_i}.inject(:+)
 bendermoney= bender.map {|bendermoney| bendermoney["Money"].to_i}.inject(:+)
 leelamoney= leela.map {|frymoney| frymoney["Money"].to_i}.inject(:+)

 frysbonus = frymoney * 0.1
 amysbonus = amymoney * 0.1
 bendersbonus = bendermoney * 0.1
 leelasbonus = leelamoney * 0.1

 frystrip = fry.length
 amystrip = amy.length
 benderstrip = bender.length
 leelastrip = leela.length

def formatted_number(n)
 a,b = sprintf("%0.2f", n).split('.')
 a.gsub!(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
 "$#{a}.#{b}"
end

new_html = ERB.new(html).result(binding)
# write

File.open("index.html", "wb") do |file|
 file.write(new_html)
 file.close
end
