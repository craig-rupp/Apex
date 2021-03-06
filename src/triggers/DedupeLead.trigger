trigger DedupeLead on Lead (before insert) {
	List<Group> dataQualityGroup = [SELECT Id FROM Group 
										WHERE DeveloperName = 'Data_Quality'
											LIMIT 1]; 
	for(Lead leadOpp : Trigger.new){
		if(leadOpp.Email != null){
			//1) - Search for Matching Contacts
			String firstNameMatch;
			if(leadOpp.FirstName != null){
				firstNameMatch = leadOpp.FirstName.substring(0, 1) + '%';
			}
			string leadCompany;
			if(leadOpp.Company != null){
				leadCompany = '%' + leadOpp.Company + '%';
			}
			List<Contact> matchingContacts = [SELECT Id, FirstName, LastName, Account.Name FROM Contact 
												WHERE (Email = :leadOpp.Email AND Email != null)
												OR (FirstName != null AND 
												FirstName LIKE :firstNameMatch
												AND LastName = :leadOpp.LastName 
												AND Account.Name LIKE :leadCompany
												 )];
			System.debug(matchingContacts.size() + ' contact(s) found');
			
			if(!matchingContacts.isEmpty()){
				//2)If matches found, assign to data quality que
				//make sure dataQualityGroup isn't empty
				if(!dataQualityGroup.isEmpty()){
					leadOpp.OwnerId = dataQualityGroup.get(0).Id;
				}
				//3)Add dupe contact IDS into lead description
				String dupeMessageString = 'Duplicate contact(s) found:\n';
				for(Contact matchingContact : matchingContacts){
					dupeMessageString += matchingContact.FirstName + ' '
									   + matchingContact.LastName + ', '
									   + matchingContact.Account.Name + '('
									   + matchingContact.Id + ')\n';
				}
				if(leadOpp.Description != null){
					leadOpp.Description = dupeMessageString + '\n' + leadOpp.Description;
				}
			}
		}

	}
}