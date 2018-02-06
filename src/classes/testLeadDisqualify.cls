@isTest
private class testLeadDisqualify {
	
	@isTest static void leadStatusDisqualify() {
		// Implement test code
		Lead testLead = new Lead();
		testLead.FirstName = 'Joe';
		testLead.LastName = 'Test';
		testLead.Company = 'Ferrari';
		insert testLead;
	}
}