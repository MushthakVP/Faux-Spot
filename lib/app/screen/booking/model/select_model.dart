
List<SelectedModel> selectedList = [
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: true, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
  SelectedModel(booked: false, selected: false),
];

class SelectedModel {
  bool selected;
  bool booked;
  SelectedModel({required this.booked, required this.selected});
}

List<TimeModel> timeListMorning = [
  TimeModel(time: "5:00 - 6:00", index: 0),
  TimeModel(time: "6:00 - 7:00", index: 1),
  TimeModel(time: "7:00 - 8:00", index: 2),
  TimeModel(time: "8:00 - 9:00", index: 3),
  TimeModel(time: "9:00 - 10:00", index: 4),
  TimeModel(time: "10:00 - 11:00", index: 5),
];

List<TimeModel> timeListAfternoon = [
  TimeModel(time: "2:00 - 3:00", index: 6),
  TimeModel(time: "3:00 - 4:00", index: 7),
  TimeModel(time: "4:00 - 5:00", index: 8),
];

List<TimeModel> timeListEvening = [
  TimeModel(time: "5:00 - 6:00", index: 9),
  TimeModel(time: "6:00 - 7:00", index: 10),
  TimeModel(time: "7:00 - 8:00", index: 11),
  TimeModel(time: "8:00 - 9:00", index: 12),
  TimeModel(time: "9:00 - 10:00", index: 13),
  TimeModel(time: "10:00 - 11:00", index: 14),
  TimeModel(time: "11:00 - 12:00", index: 15),
  TimeModel(time: "12:00 - 1:00", index: 16),
];

class TimeModel {
  String time;
  int index;

  TimeModel({required this.time, required this.index});
}
