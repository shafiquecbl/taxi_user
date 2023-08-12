class Address {
  final String title;
  final String subtitle;

  Address({
    required this.title,
    required this.subtitle,
  });

  Address copyWith({
    String? title,
    String? subtitle,
  }) {
    return Address(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      title: map['title'],
      subtitle: map['subtitle'],
    );
  }
}

List<Address> addressList = [
  Address(
      title: 'Current Address',
      subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
  Address(title: 'Home', subtitle: 'Crescent Bahuman Limited, Pindi Bhattian'),
  Address(
      title: 'Office',
      subtitle:
          '2nd Floor, Bismillah Plaza, near MCB Bank, Ghori Town Phase 5, Islamabad'),
  Address(
      title: 'Other',
      subtitle: '2nd Floor, Tower Plaza, Ghori Town Phase 3, Islamabad'),
];
