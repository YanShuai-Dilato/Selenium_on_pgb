# base_env.rb

module BaseEnv

    def base_url()
    	"https://buildstage.phonegap.com"     
    end
    def browser()
         
        if $browser == :chrome
            #profile = Selenium::WebDriver::Chrome::Profile.new
            #profile['intl.accept_languages'] = $lang.to_s
        	Selenium::WebDriver.for :chrome 
        elsif $browser == :firefox
            profile = Selenium::WebDriver::Firefox::Profile.new
            profile['intl.accept_languages'] = $lang.to_s
            Selenium::WebDriver.for :firefox , :profile => profile
        else
            Selenium::WebDriver.for $browser 
        end
    end  

    def isElementPresent?(type, selector)
        begin
            @driver.find_element(type, selector)
            true
        rescue Selenium::WebDriver::Error::NoSuchElementError
            false
        end
    end
 
end

=begin
    
    Available Country value. 

    US GB CA AU AF AL DZ AS AD AO AI AQ AG AR AM AW AU AT AZ BS BH BD BB BY 
    BE BZ BJ BM BT BO BA BW BR IO BN BG BF BI KH CM CA CV KY CF TD CL CN CX 
    CC CO KM CG CK CR HR CY CZ CD DK DJ DM DO TL EC EG SV GQ ER EE ET FK FO 
    FJ FI FR GF PF GA GM GE DE GH GI GR GL GD GP GT GN GW GY HT HN HK HU IS 
    IN ID IQ IE IL IT CI JM JP JO KZ KE KI KR KW KG LA LV LB LS LR LY LI LT 
    LU MO MK MG MW MY MV ML MT MH MQ MR MU YT MX FM MD MC MN ME MS MA MZ MM 
    NA NR NP NL AN NC NZ NI NE NG NU NF NO OM PK PS PA PG PY PE PH PN PL PT 
    QA RE RO RU RW SH KN LC PM VC WS SM ST SA SN RS SC SL SG SK SI SB SO ZA 
    GS ES LK SR SJ SZ SE CH TW TJ TZ TH TG TK TO TT TN TR TM TC TV UG UA AE 
    GB US UM UY UZ VU VA VE VN VG WF EH YE ZM ZW

=end