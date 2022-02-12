class MeetingModel {
  String meetingId;
  String meetingTitle;
  String userName;
  String meetingDate;

  MeetingModel(
      {this.meetingId, this.meetingTitle, this.userName, this.meetingDate});

  static MeetingModel fromMap(Map<String, dynamic> map) {
    return MeetingModel(
      meetingId: map["meetingId"],
      meetingTitle: map["meeting_title"],
      userName: map["user_Name"],
      meetingDate: map["date"],
    );
  }
}
