
import 'dart:math';

class AllocateStockUtils {
  const AllocateStockUtils._();


  static String get email {
    final random = Random();
    final firstNames = [
      'John',
      'Emily',
      'Michael',
      'Sophia',
      'Daniel',
      'Olivia',
      'David',
      'Emma',
      'Andrew',
      'Isabella'
    ];
    final lastNames = [
      'Smith',
      'Johnson',
      'Williams',
      'Brown',
      'Jones',
      'Garcia',
      'Miller',
      'Davis',
      'Rodriguez',
      'Martinez'
    ];

    final domains = [
      'gmail.com',
      'yahoo.com',
      'hotmail.com',
      'outlook.com',
      'icloud.com',
      'aol.com',
      'zoho.com',
      'protonmail.com',
      'yandex.com',
      'mail.com',
    ];

    final firstName = firstNames[random.nextInt(firstNames.length)];
    final lastName = lastNames[random.nextInt(lastNames.length)];
    return
      '$firstName.$lastName@${domains[random.nextInt(domains.length)]}';
  }
}
