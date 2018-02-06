@isTest
private class accountArsenalTasks {
	
	@isTest static void test_method_one() {
		//create account with multi-select items 
		Account acc = new Account();
		acc.Name = 'Testing';
		acc.Arsenal__c = 'Wenger;Wilshere;Lacazette';
		insert acc;
	}
}