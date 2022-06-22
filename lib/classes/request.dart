class Request {
  String fromEmail;
  String toEmail;
  String status;

  @override
  String toString() {
    return 'Request{fromEmail: $fromEmail, toEmail: $toEmail, status: $status}';
  }

  Request({
    required this.fromEmail,
    required this.toEmail,
    required this.status,
  });

  bool checkFields() {
    if (fromEmail.isEmpty || toEmail.isEmpty) {
      return true;
    }
    return false;
  }

  Map<String, Object?> toJson() {
    return {'fromEmail': fromEmail, 'toEmail': toEmail, 'status': status};
  }
}

enum Status {
  pending, //0
  accepted, //1
  rejected, //2 Status.values[2]
}
