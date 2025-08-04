import 'dart:convert';

class HomePrayerTimeModel {
    final int? code;
    final String? status;
    final Data? data;

    HomePrayerTimeModel({
        this.code,
        this.status,
        this.data,
    });

    factory HomePrayerTimeModel.fromRawJson(String str) => HomePrayerTimeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HomePrayerTimeModel.fromJson(Map<String, dynamic> json) => HomePrayerTimeModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    final Times? times;
    final Date? date;
    final Qibla? qibla;
    final ProhibitedTimes? prohibitedTimes;

    Data({
        this.times,
        this.date,
        this.qibla,
        this.prohibitedTimes,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        times: json["times"] == null ? null : Times.fromJson(json["times"]),
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        qibla: json["qibla"] == null ? null : Qibla.fromJson(json["qibla"]),
        prohibitedTimes: json["prohibited_times"] == null ? null : ProhibitedTimes.fromJson(json["prohibited_times"]),
    );

    Map<String, dynamic> toJson() => {
        "times": times?.toJson(),
        "date": date?.toJson(),
        "qibla": qibla?.toJson(),
        "prohibited_times": prohibitedTimes?.toJson(),
    };
}

class Date {
    final String? readable;
    final String? timestamp;
    final Hijri? hijri;
    final Gregorian? gregorian;

    Date({
        this.readable,
        this.timestamp,
        this.hijri,
        this.gregorian,
    });

    factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        readable: json["readable"],
        timestamp: json["timestamp"],
        hijri: json["hijri"] == null ? null : Hijri.fromJson(json["hijri"]),
        gregorian: json["gregorian"] == null ? null : Gregorian.fromJson(json["gregorian"]),
    );

    Map<String, dynamic> toJson() => {
        "readable": readable,
        "timestamp": timestamp,
        "hijri": hijri?.toJson(),
        "gregorian": gregorian?.toJson(),
    };
}

class Gregorian {
    final String? date;
    final String? format;
    final String? day;
    final GregorianWeekday? weekday;
    final GregorianMonth? month;
    final String? year;
    final Designation? designation;

    Gregorian({
        this.date,
        this.format,
        this.day,
        this.weekday,
        this.month,
        this.year,
        this.designation,
    });

    factory Gregorian.fromRawJson(String str) => Gregorian.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: json["weekday"] == null ? null : GregorianWeekday.fromJson(json["weekday"]),
        month: json["month"] == null ? null : GregorianMonth.fromJson(json["month"]),
        year: json["year"],
        designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday?.toJson(),
        "month": month?.toJson(),
        "year": year,
        "designation": designation?.toJson(),
    };
}

class Designation {
    final String? abbreviated;
    final String? expanded;

    Designation({
        this.abbreviated,
        this.expanded,
    });

    factory Designation.fromRawJson(String str) => Designation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        abbreviated: json["abbreviated"],
        expanded: json["expanded"],
    );

    Map<String, dynamic> toJson() => {
        "abbreviated": abbreviated,
        "expanded": expanded,
    };
}

class GregorianMonth {
    final int? number;
    final String? en;

    GregorianMonth({
        this.number,
        this.en,
    });

    factory GregorianMonth.fromRawJson(String str) => GregorianMonth.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
        number: json["number"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
    };
}

class GregorianWeekday {
    final String? en;

    GregorianWeekday({
        this.en,
    });

    factory GregorianWeekday.fromRawJson(String str) => GregorianWeekday.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GregorianWeekday.fromJson(Map<String, dynamic> json) => GregorianWeekday(
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
    };
}

class Hijri {
    final String? date;
    final String? format;
    final String? day;
    final HijriWeekday? weekday;
    final HijriMonth? month;
    final String? year;
    final Designation? designation;
    final List<dynamic>? holidays;
    final List<dynamic>? adjustedHolidays;
    final String? method;
    final int? shift;

    Hijri({
        this.date,
        this.format,
        this.day,
        this.weekday,
        this.month,
        this.year,
        this.designation,
        this.holidays,
        this.adjustedHolidays,
        this.method,
        this.shift,
    });

    factory Hijri.fromRawJson(String str) => Hijri.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: json["weekday"] == null ? null : HijriWeekday.fromJson(json["weekday"]),
        month: json["month"] == null ? null : HijriMonth.fromJson(json["month"]),
        year: json["year"],
        designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
        holidays: json["holidays"] == null ? [] : List<dynamic>.from(json["holidays"]!.map((x) => x)),
        adjustedHolidays: json["adjustedHolidays"] == null ? [] : List<dynamic>.from(json["adjustedHolidays"]!.map((x) => x)),
        method: json["method"],
        shift: json["shift"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday?.toJson(),
        "month": month?.toJson(),
        "year": year,
        "designation": designation?.toJson(),
        "holidays": holidays == null ? [] : List<dynamic>.from(holidays!.map((x) => x)),
        "adjustedHolidays": adjustedHolidays == null ? [] : List<dynamic>.from(adjustedHolidays!.map((x) => x)),
        "method": method,
        "shift": shift,
    };
}

class HijriMonth {
    final int? number;
    final String? en;
    final String? ar;
    final int? days;

    HijriMonth({
        this.number,
        this.en,
        this.ar,
        this.days,
    });

    factory HijriMonth.fromRawJson(String str) => HijriMonth.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
        number: json["number"],
        en: json["en"],
        ar: json["ar"],
        days: json["days"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
        "ar": ar,
        "days": days,
    };
}

class HijriWeekday {
    final String? en;
    final String? ar;

    HijriWeekday({
        this.en,
        this.ar,
    });

    factory HijriWeekday.fromRawJson(String str) => HijriWeekday.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
        en: json["en"],
        ar: json["ar"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
    };
}

class ProhibitedTimes {
    final Noon? sunrise;
    final Noon? noon;
    final Noon? sunset;

    ProhibitedTimes({
        this.sunrise,
        this.noon,
        this.sunset,
    });

    factory ProhibitedTimes.fromRawJson(String str) => ProhibitedTimes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProhibitedTimes.fromJson(Map<String, dynamic> json) => ProhibitedTimes(
        sunrise: json["sunrise"] == null ? null : Noon.fromJson(json["sunrise"]),
        noon: json["noon"] == null ? null : Noon.fromJson(json["noon"]),
        sunset: json["sunset"] == null ? null : Noon.fromJson(json["sunset"]),
    );

    Map<String, dynamic> toJson() => {
        "sunrise": sunrise?.toJson(),
        "noon": noon?.toJson(),
        "sunset": sunset?.toJson(),
    };
}

class Noon {
    final String? start;
    final String? end;

    Noon({
        this.start,
        this.end,
    });

    factory Noon.fromRawJson(String str) => Noon.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Noon.fromJson(Map<String, dynamic> json) => Noon(
        start: json["start"],
        end: json["end"],
    );

    Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
    };
}

class Qibla {
    final Direction? direction;
    final Distance? distance;

    Qibla({
        this.direction,
        this.distance,
    });

    factory Qibla.fromRawJson(String str) => Qibla.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Qibla.fromJson(Map<String, dynamic> json) => Qibla(
        direction: json["direction"] == null ? null : Direction.fromJson(json["direction"]),
        distance: json["distance"] == null ? null : Distance.fromJson(json["distance"]),
    );

    Map<String, dynamic> toJson() => {
        "direction": direction?.toJson(),
        "distance": distance?.toJson(),
    };
}

class Direction {
    final double? degrees;
    final String? from;
    final bool? clockwise;

    Direction({
        this.degrees,
        this.from,
        this.clockwise,
    });

    factory Direction.fromRawJson(String str) => Direction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        degrees: json["degrees"]?.toDouble(),
        from: json["from"],
        clockwise: json["clockwise"],
    );

    Map<String, dynamic> toJson() => {
        "degrees": degrees,
        "from": from,
        "clockwise": clockwise,
    };
}

class Distance {
    final double? value;
    final String? unit;

    Distance({
        this.value,
        this.unit,
    });

    factory Distance.fromRawJson(String str) => Distance.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        value: json["value"]?.toDouble(),
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "unit": unit,
    };
}

class Times {
    final String? fajr;
    final String? sunrise;
    final String? dhuhr;
    final String? asr;
    final String? sunset;
    final String? maghrib;
    final String? isha;
    final String? imsak;
    final String? midnight;
    final String? firstthird;
    final String? lastthird;

    Times({
        this.fajr,
        this.sunrise,
        this.dhuhr,
        this.asr,
        this.sunset,
        this.maghrib,
        this.isha,
        this.imsak,
        this.midnight,
        this.firstthird,
        this.lastthird,
    });

    factory Times.fromRawJson(String str) => Times.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Times.fromJson(Map<String, dynamic> json) => Times(
        fajr: json["Fajr"],
        sunrise: json["Sunrise"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        imsak: json["Imsak"],
        midnight: json["Midnight"],
        firstthird: json["Firstthird"],
        lastthird: json["Lastthird"],
    );

    Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Imsak": imsak,
        "Midnight": midnight,
        "Firstthird": firstthird,
        "Lastthird": lastthird,
    };
}
