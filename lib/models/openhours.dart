class Open {
  final bool isOpen;

  Open({this.isOpen});

  Open.fromJson(Map<String, dynamic> data) : isOpen = data['isOpen'];
}
