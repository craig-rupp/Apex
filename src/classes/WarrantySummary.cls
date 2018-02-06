@isTest
private class WarrantySummary {
	
	@isTest static void createCase() {
		// Implement test code
		Case testCase = new Case();
		testCase.Status = 'New';
		testCase.Origin = 'Email';
		testCase.Product_Purchase_Date__c = Date.today();
		testCase.Product_Has_Extended_Warranty__c = false;
		testCase.Product_Total_Warranty_Days__c = 10;
		insert testCase;
	}

	@isTest static void createCaseWO(){
		Case anotherTest = new Case();
		anotherTest.Status = 'New';
		anotherTest.Origin = 'Phone';
		insert anotherTest;
	}
	
	
	
}