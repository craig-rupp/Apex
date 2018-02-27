trigger OppContactFieldSettings on Opportunity (after insert) {
	for(Opportunity opp : Trigger.new){
		if(opp.AccountId != null){
			//Get all contacts
			List<Contact> oppContacts = [SELECT Id, Description
											FROM Contact
											WHERE AccountId = :opp.AccountId];
			//Get opp Creater
			Opportunity oppRelatedInfo = [SELECT CreatedBy.Name, Owner.Name,
											Owner.Manager.Name 
											FROM Opportunity
											WHERE Id = :opp.Id];

			String contactDescription = 'New opportunity created by : ' 
									  + oppRelatedInfo.CreatedBy.Name 
									  + ', with a close date of ' + String.valueOf(opp.CloseDate) + '.\n'
									  + 'The owner of the opp is : ' + oppRelatedInfo.Owner.Name
									  + 'and this person\'s manager is : ' + oppRelatedInfo.Owner.Manager.Name;
			

			if(!oppContacts.isEmpty()){
				for(Contact myCon : oppContacts){
					String newContactDesc = contactDescription;
					//add existing contact description to the end if it exists
					if(myCon.Description != null){
						newContactDesc += '\n\n' + myCon.Description;
					}
					myCon.Description = newContactDesc;
				}
				update oppContacts;
			}
		}
	}
}