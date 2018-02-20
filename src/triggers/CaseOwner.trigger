trigger CaseOwner on Case (after insert) {

	for(Case ic : Trigger.new){
		if(ic.ContactId != null){
			Contact myCon = [SELECT Id 
								FROM Contact
								WHERE Id = :ic.ContactId];
			//Update the contact
			myCon.OwnerId = ic.CreatedById;
			update myCon;
		}
		if(ic.AccountId != null){
			Account myAcc = [SELECT Id
								FROM Account
								WHERE Id = :ic.AccountId];
			myAcc.OwnerId = ic.CreatedById;
			update myAcc;
		}
	}
}