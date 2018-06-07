require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'json'
require 'sinatra/reloader'

get '/menu' do
        menu = ["20층", "순남시래기", "양자강", "한우"]
        lunch = menu.sample
        lunch
end


get '/lotto' do

#로또
#출력 : 이번주 추천 로또 숫자는 "6개 출력" 입니다. 
my_lotto= (1..45).to_a
res = my_lotto.sample(6)
 "이번주 추천 로또 숫자는 "  + res.join(",") + " 입니다"

end

get '/check_lotto' do
    my_numbers= [*1..45]
    my_lotto = my_numbers.sample(6).sort
    
    url = "http://m.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
    lotto = HTTParty.get(url)     
    result = JSON.parse(lotto)
    numbers = []
    bonus = result["bnusNo"]
    result.each do |k,v|
        if k.include?("drwtNo")
            numbers << v
        end
    end
    count = 0
    numbers.each do |num|
        count += 1 if my_lotto.include?(num)
    end
    #등수 확인
    puts "축하합니다 1등입니다." if count == 6
    
    if count == 5 
        puts "축하합니다 2등입니다." if my_lotto.include?(bounus)
        puts "축하합니다 3등입니다."
    end
    
  "이번 회차 당첨번호는 " +  numbers.to_s
    puts "축하합니다 4등입니다." if count == 4
    puts "축하합니다 5등입니다." if count == 3
    puts "꽝입니다." if count < 3
    
   
    #puts "보너스 번호는 " + bounus.to_s
    puts "당첨 개수는 " + count.to_s
end


get '/kospi' do
response = HTTParty.get("http://finance.daum.net/quote/kospi.daum")
kospi = Nokogiri::HTML(response)
result = kospi.css("#hyenCost  >  b")
result.text
end


get '/html' do
    "<html>
        <head></head>
        <body>
            <h1>안 녕 하 세 요 ?</h1>
        </body>
    </html>"
end


get '/html_file' do
    @name = params[:name]
    name = "HOHO"
    erb :my_first_html

end

get '/calculate' do

    # num1 = params[:num1]
    # num2 = params[:num2]
    
    
    # @sum = num1.to_i + num2.to_i
    # @mul = num1.to_i * num2.to_i
    # @minus = num1.to_i - num2.to_i
    # @div = num1.to_i / num2.to_i
    
    @sum = params[:num1].to_i + params[:num2].to_i
    @mul = params[:num1].to_i * params[:num2].to_i
    @minus = params[:num1].to_i - params[:num2].to_i
    @div =  params[:num1].to_i / params[:num2].to_i
    
    
    
    erb :my_calculator
end