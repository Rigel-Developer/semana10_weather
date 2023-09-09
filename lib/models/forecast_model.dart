
class ForecastModel {
  Location? location;
  Forecast? forecast;

  ForecastModel({this.location, this.forecast});

  ForecastModel.fromJson(Map<String, dynamic> json) {
    if(json["location"] is Map) {
      location = json["location"] == null ? null : Location.fromJson(json["location"]);
    }
    if(json["forecast"] is Map) {
      forecast = json["forecast"] == null ? null : Forecast.fromJson(json["forecast"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    if(forecast != null) {
      _data["forecast"] = forecast?.toJson();
    }
    return _data;
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if(json["forecastday"] is List) {
      forecastday = json["forecastday"] == null ? null : (json["forecastday"] as List).map((e) => Forecastday.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(forecastday != null) {
      _data["forecastday"] = forecastday?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Forecastday {
  String? date;
  int? dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({this.date, this.dateEpoch, this.day, this.astro, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["date_epoch"] is int) {
      dateEpoch = json["date_epoch"];
    }
    if(json["day"] is Map) {
      day = json["day"] == null ? null : Day.fromJson(json["day"]);
    }
    if(json["astro"] is Map) {
      astro = json["astro"] == null ? null : Astro.fromJson(json["astro"]);
    }
    if(json["hour"] is List) {
      hour = json["hour"] == null ? null : (json["hour"] as List).map((e) => Hour.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["date_epoch"] = dateEpoch;
    if(day != null) {
      _data["day"] = day?.toJson();
    }
    if(astro != null) {
      _data["astro"] = astro?.toJson();
    }
    if(hour != null) {
      _data["hour"] = hour?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Hour {
  int? timeEpoch;
  String? time;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition1? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;
  int? pressureMb;
  double? pressureIn;
  int? precipMm;
  int? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? windchillC;
  double? windchillF;
  double? heatindexC;
  double? heatindexF;
  double? dewpointC;
  double? dewpointF;
  int? willItRain;
  int? chanceOfRain;
  int? willItSnow;
  int? chanceOfSnow;
  int? visKm;
  int? visMiles;
  double? gustMph;
  double? gustKph;
  int? uv;

  Hour({this.timeEpoch, this.time, this.tempC, this.tempF, this.isDay, this.condition, this.windMph, this.windKph, this.windDegree, this.windDir, this.pressureMb, this.pressureIn, this.precipMm, this.precipIn, this.humidity, this.cloud, this.feelslikeC, this.feelslikeF, this.windchillC, this.windchillF, this.heatindexC, this.heatindexF, this.dewpointC, this.dewpointF, this.willItRain, this.chanceOfRain, this.willItSnow, this.chanceOfSnow, this.visKm, this.visMiles, this.gustMph, this.gustKph, this.uv});

  Hour.fromJson(Map<String, dynamic> json) {
    if(json["time_epoch"] is int) {
      timeEpoch = json["time_epoch"];
    }
    if(json["time"] is String) {
      time = json["time"];
    }
    if(json["temp_c"] is double) {
      tempC = json["temp_c"];
    }
    if(json["temp_f"] is double) {
      tempF = json["temp_f"];
    }
    if(json["is_day"] is int) {
      isDay = json["is_day"];
    }
    if(json["condition"] is Map) {
      condition = json["condition"] == null ? null : Condition1.fromJson(json["condition"]);
    }
    if(json["wind_mph"] is double) {
      windMph = json["wind_mph"];
    }
    if(json["wind_kph"] is double) {
      windKph = json["wind_kph"];
    }
    if(json["wind_degree"] is int) {
      windDegree = json["wind_degree"];
    }
    if(json["wind_dir"] is String) {
      windDir = json["wind_dir"];
    }
    if(json["pressure_mb"] is int) {
      pressureMb = json["pressure_mb"];
    }
    if(json["pressure_in"] is double) {
      pressureIn = json["pressure_in"];
    }
    if(json["precip_mm"] is int) {
      precipMm = json["precip_mm"];
    }
    if(json["precip_in"] is int) {
      precipIn = json["precip_in"];
    }
    if(json["humidity"] is int) {
      humidity = json["humidity"];
    }
    if(json["cloud"] is int) {
      cloud = json["cloud"];
    }
    if(json["feelslike_c"] is double) {
      feelslikeC = json["feelslike_c"];
    }
    if(json["feelslike_f"] is double) {
      feelslikeF = json["feelslike_f"];
    }
    if(json["windchill_c"] is double) {
      windchillC = json["windchill_c"];
    }
    if(json["windchill_f"] is double) {
      windchillF = json["windchill_f"];
    }
    if(json["heatindex_c"] is double) {
      heatindexC = json["heatindex_c"];
    }
    if(json["heatindex_f"] is double) {
      heatindexF = json["heatindex_f"];
    }
    if(json["dewpoint_c"] is double) {
      dewpointC = json["dewpoint_c"];
    }
    if(json["dewpoint_f"] is double) {
      dewpointF = json["dewpoint_f"];
    }
    if(json["will_it_rain"] is int) {
      willItRain = json["will_it_rain"];
    }
    if(json["chance_of_rain"] is int) {
      chanceOfRain = json["chance_of_rain"];
    }
    if(json["will_it_snow"] is int) {
      willItSnow = json["will_it_snow"];
    }
    if(json["chance_of_snow"] is int) {
      chanceOfSnow = json["chance_of_snow"];
    }
    if(json["vis_km"] is int) {
      visKm = json["vis_km"];
    }
    if(json["vis_miles"] is int) {
      visMiles = json["vis_miles"];
    }
    if(json["gust_mph"] is double) {
      gustMph = json["gust_mph"];
    }
    if(json["gust_kph"] is double) {
      gustKph = json["gust_kph"];
    }
    if(json["uv"] is int) {
      uv = json["uv"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time_epoch"] = timeEpoch;
    _data["time"] = time;
    _data["temp_c"] = tempC;
    _data["temp_f"] = tempF;
    _data["is_day"] = isDay;
    if(condition != null) {
      _data["condition"] = condition?.toJson();
    }
    _data["wind_mph"] = windMph;
    _data["wind_kph"] = windKph;
    _data["wind_degree"] = windDegree;
    _data["wind_dir"] = windDir;
    _data["pressure_mb"] = pressureMb;
    _data["pressure_in"] = pressureIn;
    _data["precip_mm"] = precipMm;
    _data["precip_in"] = precipIn;
    _data["humidity"] = humidity;
    _data["cloud"] = cloud;
    _data["feelslike_c"] = feelslikeC;
    _data["feelslike_f"] = feelslikeF;
    _data["windchill_c"] = windchillC;
    _data["windchill_f"] = windchillF;
    _data["heatindex_c"] = heatindexC;
    _data["heatindex_f"] = heatindexF;
    _data["dewpoint_c"] = dewpointC;
    _data["dewpoint_f"] = dewpointF;
    _data["will_it_rain"] = willItRain;
    _data["chance_of_rain"] = chanceOfRain;
    _data["will_it_snow"] = willItSnow;
    _data["chance_of_snow"] = chanceOfSnow;
    _data["vis_km"] = visKm;
    _data["vis_miles"] = visMiles;
    _data["gust_mph"] = gustMph;
    _data["gust_kph"] = gustKph;
    _data["uv"] = uv;
    return _data;
  }
}

class Condition1 {
  String? text;
  String? icon;
  int? code;

  Condition1({this.text, this.icon, this.code});

  Condition1.fromJson(Map<String, dynamic> json) {
    if(json["text"] is String) {
      text = json["text"];
    }
    if(json["icon"] is String) {
      icon = json["icon"];
    }
    if(json["code"] is int) {
      code = json["code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["text"] = text;
    _data["icon"] = icon;
    _data["code"] = code;
    return _data;
  }
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonIllumination;

  Astro({this.sunrise, this.sunset, this.moonrise, this.moonset, this.moonPhase, this.moonIllumination});

  Astro.fromJson(Map<String, dynamic> json) {
    if(json["sunrise"] is String) {
      sunrise = json["sunrise"];
    }
    if(json["sunset"] is String) {
      sunset = json["sunset"];
    }
    if(json["moonrise"] is String) {
      moonrise = json["moonrise"];
    }
    if(json["moonset"] is String) {
      moonset = json["moonset"];
    }
    if(json["moon_phase"] is String) {
      moonPhase = json["moon_phase"];
    }
    if(json["moon_illumination"] is String) {
      moonIllumination = json["moon_illumination"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    _data["moonrise"] = moonrise;
    _data["moonset"] = moonset;
    _data["moon_phase"] = moonPhase;
    _data["moon_illumination"] = moonIllumination;
    return _data;
  }
}

class Day {
  double? maxtempC;
  double? maxtempF;
  double? mintempC;
  int? mintempF;
  double? avgtempC;
  double? avgtempF;
  double? maxwindMph;
  double? maxwindKph;
  int? totalprecipMm;
  int? totalprecipIn;
  int? avgvisKm;
  int? avgvisMiles;
  int? avghumidity;
  Condition? condition;
  int? uv;

  Day({this.maxtempC, this.maxtempF, this.mintempC, this.mintempF, this.avgtempC, this.avgtempF, this.maxwindMph, this.maxwindKph, this.totalprecipMm, this.totalprecipIn, this.avgvisKm, this.avgvisMiles, this.avghumidity, this.condition, this.uv});

  Day.fromJson(Map<String, dynamic> json) {
    if(json["maxtemp_c"] is double) {
      maxtempC = json["maxtemp_c"];
    }
    if(json["maxtemp_f"] is double) {
      maxtempF = json["maxtemp_f"];
    }
    if(json["mintemp_c"] is double) {
      mintempC = json["mintemp_c"];
    }
    if(json["mintemp_f"] is int) {
      mintempF = json["mintemp_f"];
    }
    if(json["avgtemp_c"] is double) {
      avgtempC = json["avgtemp_c"];
    }
    if(json["avgtemp_f"] is double) {
      avgtempF = json["avgtemp_f"];
    }
    if(json["maxwind_mph"] is double) {
      maxwindMph = json["maxwind_mph"];
    }
    if(json["maxwind_kph"] is double) {
      maxwindKph = json["maxwind_kph"];
    }
    if(json["totalprecip_mm"] is int) {
      totalprecipMm = json["totalprecip_mm"];
    }
    if(json["totalprecip_in"] is int) {
      totalprecipIn = json["totalprecip_in"];
    }
    if(json["avgvis_km"] is int) {
      avgvisKm = json["avgvis_km"];
    }
    if(json["avgvis_miles"] is int) {
      avgvisMiles = json["avgvis_miles"];
    }
    if(json["avghumidity"] is int) {
      avghumidity = json["avghumidity"];
    }
    if(json["condition"] is Map) {
      condition = json["condition"] == null ? null : Condition.fromJson(json["condition"]);
    }
    if(json["uv"] is int) {
      uv = json["uv"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["maxtemp_c"] = maxtempC;
    _data["maxtemp_f"] = maxtempF;
    _data["mintemp_c"] = mintempC;
    _data["mintemp_f"] = mintempF;
    _data["avgtemp_c"] = avgtempC;
    _data["avgtemp_f"] = avgtempF;
    _data["maxwind_mph"] = maxwindMph;
    _data["maxwind_kph"] = maxwindKph;
    _data["totalprecip_mm"] = totalprecipMm;
    _data["totalprecip_in"] = totalprecipIn;
    _data["avgvis_km"] = avgvisKm;
    _data["avgvis_miles"] = avgvisMiles;
    _data["avghumidity"] = avghumidity;
    if(condition != null) {
      _data["condition"] = condition?.toJson();
    }
    _data["uv"] = uv;
    return _data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    if(json["text"] is String) {
      text = json["text"];
    }
    if(json["icon"] is String) {
      icon = json["icon"];
    }
    if(json["code"] is int) {
      code = json["code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["text"] = text;
    _data["icon"] = icon;
    _data["code"] = code;
    return _data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  Location({this.name, this.region, this.country, this.lat, this.lon, this.tzId, this.localtimeEpoch, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["region"] is String) {
      region = json["region"];
    }
    if(json["country"] is String) {
      country = json["country"];
    }
    if(json["lat"] is double) {
      lat = json["lat"];
    }
    if(json["lon"] is double) {
      lon = json["lon"];
    }
    if(json["tz_id"] is String) {
      tzId = json["tz_id"];
    }
    if(json["localtime_epoch"] is int) {
      localtimeEpoch = json["localtime_epoch"];
    }
    if(json["localtime"] is String) {
      localtime = json["localtime"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["region"] = region;
    _data["country"] = country;
    _data["lat"] = lat;
    _data["lon"] = lon;
    _data["tz_id"] = tzId;
    _data["localtime_epoch"] = localtimeEpoch;
    _data["localtime"] = localtime;
    return _data;
  }
}