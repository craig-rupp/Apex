@isTest
private class HelloWorldTest {
	
	@isTest static void update_lead() {
		// Implement test code
			Lead myLead = new Lead();
			myLead.FirstName = 'Craig';
			myLead.LastName = 'Rupp';
			myLead.Company = 'Arsenal';
			insert myLead; 

			myLead.Company = 'Man United';
			update myLead;
	}
}