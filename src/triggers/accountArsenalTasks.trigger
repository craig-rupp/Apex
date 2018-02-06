trigger accountArsenalTasks on Account (after insert) {

	//List<Account> taskAccounts = new List<Account>();
	for(Account allAccounts : Trigger.new){
		if(allAccounts.Arsenal__c != null){
			List<String> selectedMembers = new List<String>();
			selectedMembers = allAccounts.Arsenal__c.split(';');
			System.debug(selectedMembers);
			List<Task> addDem = new List<Task>();
			for(String teamMember : selectedMembers){
				Task newNew = new Task();
				newNew.Subject = teamMember;
				newNew.WhatId = allAccounts.Id;
				addDem.add(newNew);
			}
			insert addDem;
		}
	}

}