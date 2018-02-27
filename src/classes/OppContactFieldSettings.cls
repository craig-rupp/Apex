@isTest
private class OppContactFieldSettings {
	
	@isTest static void createOpp() {
		//User to Manage
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

		Account acct = new Account();
		acct.Name = 'Bodega Boys';
		insert acct;

		List<Contact> contacts = new List<Contact>();
		for(integer i=0; i < 3; i++){
			String iString = String.valueOf(i);
			Contact myCon = new Contact();
			myCon.LastName = iString;
			myCon.AccountId = acct.Id;
			myCon.Description = iString;
			contacts.add(myCon);
		}
		insert contacts;

		Opportunity opp = new Opportunity();
		opp.Name = 'We outcha here';
		opp.StageName = 'Prospecting';
		opp.CloseDate = Date.today();
		opp.AccountId = acct.Id;
		opp.OwnerId = opp_owner.Id;
		insert opp;

		List<Contact> updatedContacts = [SELECT Description
											FROM Contact
											WHERE AccountId = :acct.Id];
		opp = [SELECT CreatedBy.Name, CloseDate
				FROM Opportunity
				WHERE Id = :opp.Id];

		for(Contact iC : contacts){
			System.assert(iC.Description.contains(opp.CreatedBy.Name));
			System.assert(iC.Description.contains(opp_owner.FirstName));
			System.assert(iC.Description.contains(opp_owner.LastName));
			System.assert(iC.Description.contains(String.valueOf(opp.CloseDate)));
			//System.assert(iC.Description.contains)
		} 
	}
}