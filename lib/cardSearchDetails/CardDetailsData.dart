class CardDetailsData {
  final String firstName;
  final String lastName;
  final String position;
  final String companyName;
  final Map<String, dynamic> links; // Add other properties as needed

  CardDetailsData({
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.companyName,
    required this.links,
  });
}
