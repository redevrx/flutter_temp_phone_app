class SmsResponse {
  final String sendPhone;
  final String recvTime;
  final String text;

  SmsResponse(
      {required this.sendPhone, required this.recvTime, required this.text});

  static List<SmsResponse> fromJson(dynamic mJson) {
    return (mJson as List)
        .map((json) => SmsResponse(
              sendPhone: json['send_phone'] ?? '',
              recvTime: json['recv_time'] ?? '',
              text: json['text'] ?? '',
            ))
        .toList();
  }

  Map<String, dynamic> get toJson => Map.of({
        'send_phone': sendPhone,
        'recv_time': recvTime,
        'text': text,
      });
}
