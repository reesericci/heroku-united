module Domesticable
  extend ActiveSupport::Concern

  included do
    enum :country, Hash[*Country.all.collect { |v| [v.to_sym, v.to_s] }.flatten]
    attr_reader :country

    def country
      Domesticable::Country.new(self[:country]&.to_sym)
    end

    validates :country, presence: true, if: :country?

    def country?
      c = Domesticable::Country.new(self[:country]&.to_sym)
      if c.blank?
        errors.add(:country, "is blank")
      end
    rescue Domesticable::InvalidCountry
      errors.add(:country, "is an invalid country")
    end
  end

  class Country
    def initialize(name)
      if name.respond_to?(:to_str)
        @name = Country.from_str(name)
      elsif name.respond_to?(:to_sym)
        @name = Country.from_sym(name)
      elsif name.blank?
        nil
      else
        raise "Invalid format, please use a String or Symbol"
      end
    end

    def self.from_str(name)
      if @@all_str.include?(name)
        name
      else
        raise InvalidCountry
      end
    end

    def self.from_sym(name)
      if Country.all.map { |c| c.to_sym }.include?(name)
        sym_hash[name]
      else
        raise InvalidCountry
      end
    end

    def to_s
      @name
    end

    alias_method :to_str, :to_s

    def to_sym
      @name.tr(",", "_").tr(" ", "_").gsub("__", "_").downcase.to_sym
    end
    
    def name
      @name
    end

    def self.all
      @@all_str.map do |c|
        new(c)
      end
    end

    def self.sym_hash
      Hash[*Country.all.collect { |v| [v.to_sym, v.to_s] }.flatten]
    end

    @@all_str = "Afghanistan
Albania
Algeria
American Samoa, United States
Andorra
Angola
Anguilla
Antigua and Barbuda
Argentina
Armenia
Aruba
Ascension
Australia
Austria
Azerbaijan
Bahamas
Bahrain
Bangladesh
Barbados
Belarus
Belgium
Belize
Benin
Bermuda
Bhutan
Bolivia
Bonaire, Sint Eustatius, and Saba
Bosnia-Herzegovina
Botswana
Brazil
British Virgin Islands
Brunei Darussalam
Bulgaria
Burkina Faso
Burma
Burundi
Cambodia
Cameroon
Canada
Cape Verde
Cayman Islands
Central African Republic
Chad
Channel Islands (Jersey, Guernsey, Alderney)
Chile
China
Christiansted, US Virgin Islands, United States
Chuuk, Micronesia, United States
Colombia
Comoros
Congo, Democratic Republic of the
Congo, Republic of the
Costa Rica
Cote d’Ivoire
Croatia
Cuba
Curacao
Cyprus
Czech Republic
Denmark
Djibouti
Dominica
Dominican Republic
Ebeye, Marshall Islands, United States
Ecuador
Egypt
El Salvador
Equatorial Guinea
Eritrea
Estonia
Eswatini
Ethiopia
Falkland Islands
Faroe Islands
Fiji
Finland
France
Frederiksted, US Virgin Islands, United States
French Guiana
French Polynesia
Gabon
Gambia
Georgia, Republic of
Germany
Ghana
Gibraltar
Greece
Greenland
Grenada
Guadeloupe
Guatemala
Guinea
Guinea–Bissau
Guyana
Haiti
Honduras
Hong Kong
Hungary
Iceland
India
Indonesia
Iran
Iraq
Ireland
Israel
Italy
Jamaica
Japan
Jordan
Kazakhstan
Kenya
Kingshill, US Virgin Islands, United States
Kiribati
Korea, Democratic People’s Republic of
Kosovo, Republic of
Kosrae, Micronesia, United States
Kuwait
Kwajalein, Marshall Islands, United States
Kyrgyzstan
Laos
Latvia
Lebanon
Lesotho
Liberia
Libya
Liechtenstein
Lithuania
Luxembourg
Macao
Madagascar
Majuro, Marshall Islands, United States
Malawi
Malaysia
Maldives
Mali
Malta
Manua Islands, American Samoa
Marshall Islands, Republic of the
Martinique
Mauritania
Mauritius
Mexico
Micronesia, Federated States of
Moldova
Mongolia
Montenegro
Montserrat
Morocco
Mozambique
Namibia
Nauru
Nepal
Netherlands
New Caledonia
New Zealand
Nicaragua
Niger
Nigeria
North Korea (Korea, Democratic People’s
Republic of)
North Macedonia, Republic of
Northern Mariana Islands, Commonwealth of
Norway
Oman
Pago Pago, American Samoa, United States
Pakistan
Panama
Papua New Guinea
Paraguay
Peru
Philippines
Pitcairn Island
Pohnpei, Micronesia, United States
Poland
Portugal
Qatar
Reunion
Romania
Rota, Northern Mariana Islands
Russia
Rwanda
Saint Croix, US Virgin Islands
Saint Helena
Saint John, US Virgin Islands
Saint Kitts and Nevis
Saint Lucia
Saint Pierre and Miquelon
Saint Thomas, US Virgin Islands
Saint Vincent and the Grenadines
Saipan, Northern Mariana Islands
Samoa
Samoa, American, United States
San Marino
Sao Tome and Principe
Saudi Arabia
Senegal
Serbia, Republic of
Seychelles
Sierra Leone
Singapore
Slovenia
Solomon Islands
Somalia
South Africa
South Sudan, Republic of
Spain
Sri Lanka
Sudan
Suriname
Swain’s Island, American Samoa
Sweden
Switzerland
Taiwan
Tajikistan
Tanzania
Thailand
Timor-Leste, Democratic Republic of
Tinian, Northern Mariana Islands
Togo
Tonga
Trinidad and Tobago
Tristan da Cunha
Tunisia
Turkiye, Republic of
Turkmenistan
Turks and Caicos Islands
Tutuila Island, American Samoa
Tuvalu
Uganda
Ukraine
United Arab Emirates
United Kingdom of Great Britain and Northern Ireland
United Nations, New York, United States
United States
Uruguay
Uzbekistan
Vanuatu
Vatican City
Venezuela
Vietnam
Wallis and Futuna Islands
Yap, Micronesia, United States
Yemen
Zambia
Zimbabwe".split(/\n+/)
  end

  class InvalidCountry < StandardError
  end
end
