@isTest
private class AccountPhoneUpdate {
	
	@isTest static void AcctPhoneUpdate() {
		// Create Acct, Create multiple Contacts - associated to Acct with same Mailing
		String country = 'US';
		Account testAcct = new Account();
		testAcct.Name = 'Wowowwo';
		testAcct.BillingCountry = country;
		insert testAcct;

		List<Contact>contacts = new List<Contact>();

		Contact sameMailing = new Contact();
		sameMailing.FirstName = 'Craig';
		sameMailing.LastName = 'Yowza';
		sameMailing.AccountId = testAcct.Id;
		sameMailing.MailingCountry = country;
		contacts.add(sameMailing);

		Contact diffMailing = new Contact();
		diffMailing.FirstName = 'Rolf';
		diffMailing.LastName = 'Adams';
		diffMailing.AccountId = testAcct.Id;
		diffMailing.MailingCountry = 'Germany';
		contacts.add(diffMailing);
		insert contacts;

		//Update Account's Phone Number
		String phoneNumber = '1234556';
		testAcct.Phone = phoneNumber;
		update testAcct;

		List<Contact> queried_contacts = [SELECT OtherPhone, Id
							FROM Contact
							WHERE AccountId = :testAcct.Id
							ORDER BY FirstName DESC];

		System.assertEquals(null, queried_contacts.get(0).OtherPhone);
		System.assertEquals(phoneNumber, queried_contacts.get(1).OtherPhone);
	}	
}