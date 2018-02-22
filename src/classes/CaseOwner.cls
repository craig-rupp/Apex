@isTest
private class CaseOwner {
	
	@isTest static void createCaseOnContact() {
		// Implement test code
		User opp_owner = new User();
		opp_owner.FirstName = 'Henrikh';
		opp_owner.LastName = 'Mkhi';
		opp_owner.Email = 'hmkhi@cannons.com';
		opp_owner.Username = 'hmkhi@cannons.com';
		opp_owner.Alias = 'armenian';
		opp_owner.ProfileId = [SELECT Id 
								FROM Profile
								WHERE Name = 'System Administrator'].Id;
		opp_owner.ManagerId = null;
		opp_owner.LanguageLocaleKey = 'en_US';
		opp_owner.EmailEncodingKey = 'UTF-8';
		opp_owner.LocaleSidKey = 'en_US';
		opp_owner.TimeZoneSidKey = 'America/Denver';
		insert opp_owner;

		Contact my_con = new Contact();
		my_con.FirstName = 'Mino';
		my_con.LastName = 'Riolas';
		my_con.OwnerId = opp_owner.Id;
		insert my_con;

		Case myCase = new Case();
		myCase.Subject = 'Power Struggle';
		myCase.ContactId = my_con.Id;
		insert myCase; //the CreatedById will be us, UserInfo.getUserId();

		Contact changedCon = [SELECT OwnerId
								FROM Contact
								WHERE Id = :my_con.Id];

		System.assertEquals(UserInfo.getUserId(), changedCon.OwnerId);
	}
	
	@isTest static void createCaseOnAccount() {
		// Implement test code
		User opp_owner = new User();
		opp_owner.FirstName = 'Henrikh';
		opp_owner.LastName = 'Mkhi';
		opp_owner.Email = 'hmkhi@cannons.com';
		opp_owner.Username = 'hmkhi@cannons.com';
		opp_owner.Alias = 'armenian';
		opp_owner.ProfileId = [SELECT Id 
								FROM Profile
								WHERE Name = 'System Administrator'].Id;
		opp_owner.ManagerId = null;
		opp_owner.LanguageLocaleKey = 'en_US';
		opp_owner.EmailEncodingKey = 'UTF-8';
		opp_owner.LocaleSidKey = 'en_US';
		opp_owner.TimeZoneSidKey = 'America/Denver';
		insert opp_owner;

		Account acc_owner = new Account();
		acc_owner.Name = 'Arsenal';
		acc_owner.OwnerId = opp_owner.Id;
		insert acc_owner;

		Case test_case = new Case();
		test_case.Subject = 'Relationship';
		test_case.AccountId = acc_owner.Id;
		insert test_case;

		Account uppAccount = [SELECT OwnerId
								FROM Account
								WHERE Id = :acc_owner.Id];

		System.assertEquals(UserInfo.getUserId(), uppAccount.OwnerId);
	}
	
}