class NotificationResponse {
  List<NotificationData> notificationData;
  int status;

  NotificationResponse({this.notificationData, this.status});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['notification_data'] != null) {
      notificationData = new List<NotificationData>();
      json['notification_data'].forEach((v) {
        notificationData.add(new NotificationData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationData != null) {
      data['notification_data'] =
          this.notificationData.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class NotificationData {
  int read;
  String description;
  String createdAt;
  int id;
  String href;
  String title;

  NotificationData(
      {this.read,
        this.description,
        this.createdAt,
        this.id,
        this.href,
        this.title});

  NotificationData.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    description = json['description'];
    createdAt = json['created_at'];
    id = json['id'];
    href = json['href'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['href'] = this.href;
    data['title'] = this.title;
    return data;
  }
}
