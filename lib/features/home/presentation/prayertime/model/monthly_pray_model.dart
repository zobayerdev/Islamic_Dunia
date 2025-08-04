import 'dart:convert';

class MonthlyPrayTimeModel {
  dynamic title;
  dynamic query;
  dynamic monthlyPrayTimeModelFor;
  dynamic method;
  dynamic prayerMethodName;
  dynamic daylight;
  dynamic timezone;
  dynamic mapImage;
  dynamic sealevel;
  TodayWeather? todayWeather;
  dynamic link;
  dynamic qiblaDirection;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic postalCode;
  dynamic country;
  dynamic countryCode;
  List<Item>? items;
  dynamic statusValid;
  dynamic statusCode;
  dynamic statusDescription;

  MonthlyPrayTimeModel({
    this.title,
    this.query,
    this.monthlyPrayTimeModelFor,
    this.method,
    this.prayerMethodName,
    this.daylight,
    this.timezone,
    this.mapImage,
    this.sealevel,
    this.todayWeather,
    this.link,
    this.qiblaDirection,
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.countryCode,
    this.items,
    this.statusValid,
    this.statusCode,
    this.statusDescription,
  });

  factory MonthlyPrayTimeModel.fromRawJson(dynamic str) =>
      MonthlyPrayTimeModel.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory MonthlyPrayTimeModel.fromJson(Map<dynamic, dynamic> json) =>
      MonthlyPrayTimeModel(
        title: json["title"],
        query: json["query"],
        monthlyPrayTimeModelFor: json["for"],
        method: json["method"],
        prayerMethodName: json["prayer_method_name"],
        daylight: json["daylight"],
        timezone: json["timezone"],
        mapImage: json["map_image"],
        sealevel: json["sealevel"],
        todayWeather: json["today_weather"] == null
            ? null
            : TodayWeather.fromJson(json["today_weather"]),
        link: json["link"],
        qiblaDirection: json["qibla_direction"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
        countryCode: json["country_code"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        statusValid: json["status_valid"],
        statusCode: json["status_code"],
        statusDescription: json["status_description"],
      );

  Map<dynamic, dynamic> toJson() => {
        "title": title,
        "query": query,
        "for": monthlyPrayTimeModelFor,
        "method": method,
        "prayer_method_name": prayerMethodName,
        "daylight": daylight,
        "timezone": timezone,
        "map_image": mapImage,
        "sealevel": sealevel,
        "today_weather": todayWeather?.toJson(),
        "link": link,
        "qibla_direction": qiblaDirection,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
        "country_code": countryCode,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "status_valid": statusValid,
        "status_code": statusCode,
        "status_description": statusDescription,
      };
}

class Item {
  dynamic dateFor;
  dynamic fajr;
  dynamic shurooq;
  dynamic dhuhr;
  dynamic asr;
  dynamic maghrib;
  dynamic isha;

  Item({
    this.dateFor,
    this.fajr,
    this.shurooq,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
  });

  factory Item.fromRawJson(dynamic str) => Item.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<dynamic, dynamic> json) => Item(
        dateFor: json["date_for"],
        fajr: json["fajr"],
        shurooq: json["shurooq"],
        dhuhr: json["dhuhr"],
        asr: json["asr"],
        maghrib: json["maghrib"],
        isha: json["isha"],
      );

  Map<dynamic, dynamic> toJson() => {
        "date_for": dateFor,
        "fajr": fajr,
        "shurooq": shurooq,
        "dhuhr": dhuhr,
        "asr": asr,
        "maghrib": maghrib,
        "isha": isha,
      };
}

class TodayWeather {
  dynamic pressure;
  dynamic temperature;

  TodayWeather({
    this.pressure,
    this.temperature,
  });

  factory TodayWeather.fromRawJson(dynamic str) =>
      TodayWeather.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory TodayWeather.fromJson(Map<dynamic, dynamic> json) => TodayWeather(
        pressure: json["pressure"],
        temperature: json["temperature"],
      );

  Map<dynamic, dynamic> toJson() => {
        "pressure": pressure,
        "temperature": temperature,
      };
}
