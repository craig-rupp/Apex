@isTest
private class DedupeLead {
	
	@isTest static void createLeadNoDupes() {
		String newOwnerId = UserInfo.getUserId();
		// Create All Necessary required records
		Lead newLead = new Lead();
		newLead.FirstName = 'Henrikh';
		newLead.LastName = 'Mkhitaryan';
		newLead.Company = 'Arsenal';
		newLead.Email = 'Hkhmkhi@nldred.com';
		newLead.Description = 'Arsenal\'s new #7';
		newLead.OwnerId = newOwnerId;
		insert newLead;
		//Use SOQL to find latest values (before System.assert())
		Lead updatedLead = [SELECT Description, OwnerId 
							FROM Lead
							WHERE Id = :newLead.Id 
							LIMIT 1];

		//System.assert(assert that our expected outcome is true)
		System.assertEquals(newOwnerId, updatedLead.OwnerId);
		System.assertEquals(newLead.Description, updatedLead.Description);
	}
	
	@isTest static void createLeadMultipleDupes() {
		// Create Two Duplicate Contacts
		String email = 'Hkhmkhi@nldred.com';
		List<Contact> dupeContacts = new List<Contact>();

		Contact firstContact = new Contact();
		firstContact.FirstName = 'Henrikh';
		firstContact.LastName = 'Mkhitaryan';
		firstContact.Email = email;
		dupeContacts.add(firstContact);

		Contact secondContact = new Contact();
		secondContact.FirstName = 'Henrikh';
		secondContact.LastName = 'Mkhitaryan';
		secondContact.Email = email;
		dupeContacts.add(secondContact);

		insert dupeContacts;

		//Create Dupe Lead
		Lead duplicateLead = new Lead(); 
		duplicateLead.FirstName = 'Henrikh';
		duplicateLead.LastName = 'Mkhitaryan';
		duplicateLead.Company = 'Arsenal';
		duplicateLead.Email = email;
		duplicateLead.Description = 'Arsenal\'s new #7';
		duplicateLead.OwnerId = UserInfo.getUserId();
		insert duplicateLead;

		//Latest Values of our Lead
		Lead leadQuery = [SELECT OwnerId, Description
						  FROM Lead 
						  WHERE Id = :duplicateLead.Id];
		//Data Quality que info
		Group dataQQue = [SELECT Id
						  FROM Group
						  WHERE DeveloperName = 'Data_Quality'
						  LIMIT 1];

		//Assertion Time 
		System.assertEquals(dataQQue.Id, leadQuery.OwnerId);
		System.assert(leadQuery.Description.contains(firstContact.Id));
		System.assert(leadQuery.Description.contains(duplicateLead.Id));
	}
	
}