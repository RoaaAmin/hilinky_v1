import 'package:contacts_service/contacts_service.dart';

// Assuming `cardInfo` contains the card information retrieved from the Firestore database
void addContactToPhone(Map<String, dynamic> cardInfo) async {
  final Contact contact = Contact(
      givenName: cardInfo['FirstName'],
      familyName: cardInfo['LastName'] ?? '', // Add null check for last name
      phones: [Item(label: 'mobile', value: cardInfo['PhoneNumber'] ?? '')] // Add null check for phone number
  );

  // Check if the contact already exists before adding it
  Iterable<Contact> existingContacts = await ContactsService.getContacts(
    query: '${contact.givenName} ${contact.familyName}',
  );

  if (existingContacts.isEmpty) {
    await ContactsService.addContact(contact);
    print('Contact added successfully.');
  } else {
    print('Contact already exists.');
  }
}
