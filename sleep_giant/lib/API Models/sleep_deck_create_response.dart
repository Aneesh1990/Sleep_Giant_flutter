import 'package:sleep_giant/API%20Models/all_programs_list_response.dart';

class SleepDeckResponse {
  int status;
  SleepDecks sleepDecks;
  String message;

  SleepDeckResponse({this.status, this.sleepDecks, this.message});

  SleepDeckResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sleepDecks = json['sleep_decks'] != null
        ? new SleepDecks.fromJson(json['sleep_decks'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sleepDecks != null) {
      data['sleep_decks'] = this.sleepDecks.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}






