class Farmerdairy {
  PersonalDetails? personalDetails;
  CropDetails? cropDetails;

  Farmerdairy({this.personalDetails, this.cropDetails});

  Farmerdairy.fromJson(Map<String, dynamic> json) {
    personalDetails = json['personalDetails'] != null
        ? PersonalDetails.fromJson(json['personalDetails'])
        : null;
    cropDetails = json['cropDetails'] != null
        ? CropDetails.fromJson(json['cropDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['personalDetails'] = personalDetails?.toJson();
    data['cropDetails'] = cropDetails?.toJson();

    return data;
  }
}

class PersonalDetails {
  String? farmerName;
  String? fatherName;
  String? surname;
  String? village;
  String? taluka;
  String? aadharNo;
  String? phoneNo;
  String? pan;

  PersonalDetails(
      {this.farmerName,
      this.fatherName,
      this.surname,
      this.village,
      this.taluka,
      this.aadharNo,
      this.phoneNo,
      this.pan});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    farmerName = json['farmerName'];
    fatherName = json['fatherName'];
    surname = json['surname'];
    village = json['village'];
    taluka = json['taluka'];
    aadharNo = json['aadharNo'];
    phoneNo = json['phoneNo'];
    pan = json['pan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmerName'] = farmerName;
    data['fatherName'] = fatherName;
    data['surname'] = surname;
    data['village'] = village;
    data['taluka'] = taluka;
    data['aadharNo'] = aadharNo;
    data['phoneNo'] = phoneNo;
    data['pan'] = pan;
    return data;
  }
}

class CropDetails {
  List<String>? farmerStatus;
  String? actualAreaCultivation;
  String? cropUnderCultivation;
  List<Crops>? crops;
  String? irrigationSource;
  String? soilType;
  NeighboringPlots? neighboringPlots;
  List<InputDetails>? inputDetails;
  List<OutputDetails>? outputDetails;
  Location? location;

  CropDetails(
      {this.farmerStatus,
      this.actualAreaCultivation,
      this.cropUnderCultivation,
      this.crops,
      this.irrigationSource,
      this.soilType,
      this.neighboringPlots,
      this.inputDetails,
      this.outputDetails,
      this.location});

  CropDetails.fromJson(Map<String, dynamic> json) {
    farmerStatus = json['farmerStatus'].cast<String>();
    actualAreaCultivation = json['actualAreaCultivation'];
    cropUnderCultivation = json['cropUnderCultivation'];
    if (json['crops'] != null) {
      crops = <Crops>[];
      json['crops'].forEach((v) {
        crops?.add(Crops.fromJson(v));
      });
    }
    irrigationSource = json['irrigationSource'];
    soilType = json['soilType'];
    neighboringPlots = json['neighboringPlots'] != null
        ? NeighboringPlots.fromJson(json['neighboringPlots'])
        : null;
    if (json['inputDetails'] != null) {
      inputDetails = <InputDetails>[];
      json['inputDetails'].forEach((v) {
        inputDetails?.add(InputDetails.fromJson(v));
      });
    }
    if (json['outputDetails'] != null) {
      outputDetails = <OutputDetails>[];
      json['outputDetails'].forEach((v) {
        outputDetails?.add(OutputDetails.fromJson(v));
      });
    }
    location = (json['location'] != null
        ? Location.fromJson(json['location'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmerStatus'] = farmerStatus;
    data['actualAreaCultivation'] = actualAreaCultivation;
    data['cropUnderCultivation'] = cropUnderCultivation;
    if (crops != null) {
      data['crops'] = crops?.map((v) => v.toJson()).toList();
    }
    data['irrigationSource'] = irrigationSource;
    data['soilType'] = soilType;
    if (neighboringPlots != null) {
      data['neighboringPlots'] = neighboringPlots?.toJson();
    }
    if (inputDetails != null) {
      data['inputDetails'] = inputDetails?.map((v) => v.toJson()).toList();
    }
    if (outputDetails != null) {
      data['outputDetails'] = outputDetails?.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      data['location'] = location?.toJson();
    }
    return data;
  }
}

class Crops {
  String? cropName;
  String? variety;
  String? season;
  String? monthOfSowing;
  String? estimatedYield;
  String? actualYield;

  Crops(
      {this.cropName,
      this.variety,
      this.season,
      this.monthOfSowing,
      this.estimatedYield,
      this.actualYield});

  Crops.fromJson(Map<String, dynamic> json) {
    cropName = json['cropName'];
    variety = json['variety'];
    season = json['season'];
    monthOfSowing = json['monthOfSowing'];
    estimatedYield = json['estimatedYield'];
    actualYield = json['actualYield'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cropName'] = cropName;
    data['variety'] = variety;
    data['season'] = season;
    data['monthOfSowing'] = monthOfSowing;
    data['estimatedYield'] = estimatedYield;
    data['actualYield'] = actualYield;
    return data;
  }
}

class NeighboringPlots {
  String? north;
  String? south;
  String? east;
  String? west;
  BufferZone? bufferZone;
  BufferZone? statusOfFarms;

  NeighboringPlots(
      {this.north,
      this.south,
      this.east,
      this.west,
      this.bufferZone,
      this.statusOfFarms});

  NeighboringPlots.fromJson(Map<String, dynamic> json) {
    north = json['north'];
    south = json['south'];
    east = json['east'];
    west = json['west'];
    bufferZone = json['bufferZone'] != null
        ? BufferZone.fromJson(json['bufferZone'])
        : null;
    statusOfFarms = json['statusOfFarms'] != null
        ? BufferZone.fromJson(json['statusOfFarms'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['north'] = north;
    data['south'] = south;
    data['east'] = east;
    data['west'] = west;
    if (bufferZone != null) {
      data['bufferZone'] = bufferZone?.toJson();
    }
    if (statusOfFarms != null) {
      data['statusOfFarms'] = statusOfFarms?.toJson();
    }
    return data;
  }
}

class BufferZone {
  String? north;
  String? south;
  String? east;
  String? west;

  BufferZone({this.north, this.south, this.east, this.west});

  BufferZone.fromJson(Map<String, dynamic> json) {
    north = json['north'];
    south = json['south'];
    east = json['east'];
    west = json['west'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['north'] = north;
    data['south'] = south;
    data['east'] = east;
    data['west'] = west;
    return data;
  }
}

class InputDetails {
  String? nameOfParticular;
  String? cultivationArea;
  String? cropUsedFor;
  String? usedDosage;
  String? purchasedFrom;
  String? costOfTheProduct;

  InputDetails(
      {this.nameOfParticular,
      this.cultivationArea,
      this.cropUsedFor,
      this.usedDosage,
      this.purchasedFrom,
      this.costOfTheProduct});

  InputDetails.fromJson(Map<String, dynamic> json) {
    nameOfParticular = json['nameOfParticular'];
    cultivationArea = json['cultivationArea'];
    cropUsedFor = json['cropUsedFor'];
    usedDosage = json['usedDosage'];
    purchasedFrom = json['purchasedFrom'];
    costOfTheProduct = json['costOfTheProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameOfParticular'] = nameOfParticular;
    data['cultivationArea'] = cultivationArea;
    data['cropUsedFor'] = cropUsedFor;
    data['usedDosage'] = usedDosage;
    data['purchasedFrom'] = purchasedFrom;
    data['costOfTheProduct'] = costOfTheProduct;
    return data;
  }
}

class OutputDetails {
  String? nameOfCrop;
  String? cultivationArea;
  String? yield;
  String? monthOfHarvest;
  String? whereTheySold;
  String? price;

  OutputDetails(
      {this.nameOfCrop,
      this.cultivationArea,
      this.yield,
      this.monthOfHarvest,
      this.whereTheySold,
      this.price});

  OutputDetails.fromJson(Map<String, dynamic> json) {
    nameOfCrop = json['nameOfCrop'];
    cultivationArea = json['cultivationArea'];
    yield = json['yield'];
    monthOfHarvest = json['monthOfHarvest'];
    whereTheySold = json['whereTheySold'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameOfCrop'] = nameOfCrop;
    data['cultivationArea'] = cultivationArea;
    data['yield'] = yield;
    data['monthOfHarvest'] = monthOfHarvest;
    data['whereTheySold'] = whereTheySold;
    data['price'] = price;
    return data;
  }
}

class Location {
  String? lat;
  String? long;
  String? place;

  Location({this.lat, this.long, this.place});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    data['place'] = place;
    return data;
  }
}
