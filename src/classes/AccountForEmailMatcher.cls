@isTest
private class AccountForEmailMatcher {
	
	@isTest static void noMatch() {
		Contact myCon = new Contact();
		myCon.FirstName = 'Theresa';
		myCon.LastName = 'paddd';
		myCon.Email = 'tpd@samba.com';
		insert myCon;

		Contact insertedCon = [SELECT Id, AccountId 
								FROM Contact
								WHERE Id = :myCon.Id];
		System.assertEquals(null, insertedCon.AccountId);
	}
	
	@isTest static void Match() {
		// Implement test code
		String domain = 'Ssafety.com';
		Account testAcct = new Account();
		testAcct.Name = 'SambaLand';
		testAcct.Website = domain + '.ssl';
		insert testAcct;

		Contact testContact = new Contact();
		testContact.FirstName = 'TT';
		testContact.LastName = 'Hamdan';
		testContact.Email = 'TTHmdn@' + domain;
		insert testContact;

		Contact checkAcc = [SELECT AccountId
								FROM Contact
								WHERE Id = :testContact.Id];
		System.assertEquals(testAcct.Id, checkAcc.AccountId);
	}
	
}