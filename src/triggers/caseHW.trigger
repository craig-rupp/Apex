trigger caseHW on Case (before insert) {

	//Trigger that sets case status to "Closed" if more than 2 cases
	//created that day associated w/the same contact
	for(Case cT : Trigger.new){
		if(cT.ContactId != null){
			List<Case> contactCasesToday = 
				[SELECT Id
					FROM Case
						WHERE CreatedDate = Today 
							AND ContactId = :cT.ContactId];
			//If two or more are found, than close the case
			if(contactCasesToday.size() >= 2){
				cT.Status = 'Closed';
			}
		}
		if(cT.AccountId != null){
			List<Case> accountTest = [SELECT Id
										FROM Case
											WHERE CreatedDate = Today
											AND AccountId = :cT.AccountId];
			//close case depending on size of query size
			if(accountTest.size() >= 3){
				cT.Status = 'Closed';
			}
		}
	}
}