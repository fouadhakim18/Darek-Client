
class WorkerDetails {
  String name;
  final String wilaya;
  final String service;
  final double rating;
  late bool isFav;

  WorkerDetails({
    required this.name,
    required this.wilaya,
    required this.service,
    required this.rating,
    required this.isFav,
  });
}
