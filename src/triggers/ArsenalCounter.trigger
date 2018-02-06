trigger ArsenalCounter on Account (before insert, before update) {
	for(Account testAccounts : Trigger.new){
		if(testAccounts.Arsenal__c != null){
			System.debug(testAccounts.Arsenal__c.countMatches(';'));
			System.debug(testAccounts.Arsenal__c);
			Integer count = testAccounts.Arsenal__c.countMatches(';') + 1;
			System.debug('Current choices selected, after adding 1 to integer variable : ' + count);
			testAccounts.Counter__c = count;
		}
		else {
			testAccounts.Counter__c = 0;
		}
	}
}