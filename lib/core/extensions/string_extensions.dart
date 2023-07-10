import 'dart:math';

extension StringExt on String {
  /// Generates a random email address from a given name
  String get email {
    final domainList = [
      'gmail.com',
      'yahoo.com',
      'hotmail.com',
      'outlook.com',
      'protonmail.com',
      'aol.com',
      'zoho.com',
      'yandex.com',
      'mail.com',
      'gmx.com',
      'icloud.com',
      'inbox.com',
      'mail.ru',
      'yopmail.com',
      'gmx.us',
      'gmx.de',
      'gmx.co.uk',
      'gmx.fr',
      'gmx.net',
      'gmx.at',
    ];
    if (Random().nextBool()) {
      // remove the first name and append the first name's first character to
      // the last name
      final nameList = split(' ');
      final firstName = nameList.first;
      final lastName = nameList.last;
      final email = '$lastName${firstName[0]}'
          '@${domainList[Random().nextInt(domainList.length)]}';
      return email.toLowerCase();
    } else {
      // remove the last name and append the last name's first character to
      // the first name
      final nameList = split(' ');
      final firstName = nameList.first;
      final lastName = nameList.last;
      final email = '$firstName${lastName[0]}'
          '@${domainList[Random().nextInt(domainList.length)]}';
      return email.toLowerCase();
    }
  }
}
