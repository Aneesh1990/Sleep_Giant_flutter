class AllProgramsResponse {
  List<ProgramtypeData> programtypeData;
  List<SleepDecks> sleepDecks;
  int status;

  AllProgramsResponse({this.programtypeData, this.sleepDecks});

  AllProgramsResponse.fromJson(Map<String, dynamic> json) {
    if (json['programtype_data'] != null) {
      programtypeData = new List<ProgramtypeData>();
      json['programtype_data'].forEach((v) {
        programtypeData.add(new ProgramtypeData.fromJson(v));
      });
    }
    if (json['sleep_decks'] != null) {
      sleepDecks = new List<SleepDecks>();
      json['sleep_decks'].forEach((v) {
        sleepDecks.add(new SleepDecks.fromJson(v));
      });
    }

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.programtypeData != null) {
      data['programtype_data'] =
          this.programtypeData.map((v) => v.toJson()).toList();
    }
    if (this.sleepDecks != null) {
      data['sleep_decks'] = this.sleepDecks.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ProgramtypeData {
  int id;
  String name;
  List<Programs> programs;
  String link;

  ProgramtypeData({this.id, this.name, this.programs, this.link});

  ProgramtypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['programs'] != null) {
      programs = new List<Programs>();
      json['programs'].forEach((v) {
        programs.add(new Programs.fromJson(v));
      });
    }
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.programs != null) {
      data['programs'] = this.programs.map((v) => v.toJson()).toList();
    }
    data['link'] = this.link;
    return data;
  }
}

class Programs {
  int id;
  String name;
  String description;
  CoverImage coverImage;
  String programTypeId;
  Sound sound;
  int themeId;
  int duration;

  Programs(
      {this.id,
        this.name,
        this.description,
        this.coverImage,
        this.programTypeId,
        this.sound,
        this.themeId,
        this.duration});

  Programs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    coverImage = json['cover_image'] != null
        ? new CoverImage.fromJson(json['cover_image'])
        : null;
    programTypeId = json['program_type_id'];
    sound = json['sound'] != null ? new Sound.fromJson(json['sound']) : null;
    themeId = json['theme_id'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.coverImage != null) {
      data['cover_image'] = this.coverImage.toJson();
    }
    data['program_type_id'] = this.programTypeId;
    if (this.sound != null) {
      data['sound'] = this.sound.toJson();
    }
    data['theme_id'] = this.themeId;
    data['duration'] = this.duration;
    return data;
  }
}

class CoverImage {
  String original;
  String thumbnail;

  CoverImage({this.original, this.thumbnail});

  CoverImage.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Sound {
  String audio;

  Sound({this.audio});

  Sound.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    return data;
  }
}

class SleepDecks {
  int status;
  int id;
  String name;
  List<Decks> decks;

  SleepDecks({this.id, this.name, this.decks,this.status});

  SleepDecks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    name = json['name'];
    if (json['decks'] != null) {
      decks = new List<Decks>();
      json['decks'].forEach((v) {
        decks.add(new Decks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.decks != null) {
      data['decks'] = this.decks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Decks {
  int id;
  String name;
  String description;
  CoverImage coverImage;
  String programTypeId;
  String sound;
  int themeId;
  int duration;

  Decks(
      {this.id,
        this.name,
        this.description,
        this.coverImage,
        this.programTypeId,
        this.sound,
        this.themeId,
        this.duration});

  Decks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    coverImage = json['cover_image'] != null
        ? new CoverImage.fromJson(json['cover_image'])
        : null;
    programTypeId = json['program_type_id'];
    sound = json['sound'];
    themeId = json['theme_id'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.coverImage != null) {
      data['cover_image'] = this.coverImage.toJson();
    }
    data['program_type_id'] = this.programTypeId;
    data['sound'] = this.sound;
    data['theme_id'] = this.themeId;
    data['duration'] = this.duration;
    return data;
  }
}

class DeckSaved {
  int status;
  List<SleepDecks> sleepDecks;
  String message;

  DeckSaved({this.status, this.sleepDecks, this.message});

  DeckSaved.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['sleep_decks'] != null) {
      sleepDecks = new List<SleepDecks>();
      json['sleep_decks'].forEach((v) {
        sleepDecks.add(new SleepDecks.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sleepDecks != null) {
      data['sleep_decks'] = this.sleepDecks.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}