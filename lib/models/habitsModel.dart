class Habit{
  String title;
  bool isCompleted;
  DateTime scheduledTime;
  List<int> recurringDays;

  Habit({
    required this.title,
    this.isCompleted=false,
    required this.scheduledTime,
    required this.recurringDays
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'isCompleted': isCompleted,
    'time': scheduledTime.toIso8601String(), // Convert DateTime to string
    'recurringDays': recurringDays
  };


  static Habit fromJson(Map<String, dynamic> json) => Habit(
    title: json['title'],
    isCompleted: json['isCompleted'],
    scheduledTime: DateTime.parse(json['time']), // Convert from string to DateTime
    recurringDays: List<int>.from(json['recurringDays'])
  );

}