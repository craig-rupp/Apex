@isTest
private class ArsenalCounter {
	
	@isTest static void accountArsenalAccumulation() {
		// Implement test code
		//1) Create Test Account, 2) Populate Multi-picklist fields, 3) DML save
		Account astAcct = new Account();
		astAcct.Name = 'Goooners';
		astAcct.Arsenal__c = 'Ozil;Aubameyang;Wilshere';
		insert astAcct;
	}
	@isTest static void noSelectionsMade(){
		Account noChoices = new Account();
		noChoices.Name = 'Yfasdfas';
		noChoices.Arsenal__c = null;
		insert noChoices;
	}	
}