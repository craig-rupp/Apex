trigger CheckSecretInfo on Case (after insert, before update) {

	String childCaseSubject = 'Warning: Parent case may contain secret info';
	//Step 1 : Create Collection containing each of our secret keywords
	Set<String> secretKeyword = new Set<String>();
	secretKeyword.add('Credit Card');
	secretKeyword.add('Social Security');
	secretKeyword.add('SSN');
	secretKeyword.add('Bodweight');
	secretKeyword.add('Passport');

	//Step 2 : Check case to see if case contains any secret keywords
	List<Case> secretInfoCases = new List<Case>();
	Set<String> keywords = new Set<String>();
	for(Case myCase : Trigger.new){
		if(myCase.Subject != childCaseSubject){
			for(String keyword : secretKeyword){
				if(myCase.Description != null && myCase.Description.containsIgnoreCase(keyword) && secretInfoCases.isEmpty()){
					secretInfoCases.add(myCase);
					keywords.add(keyword);
				}
				else if(secretInfoCases.size() == 1 && myCase.Description.containsIgnoreCase(keyword)){
					keywords.add(keyword);
				}
			}
		}
	}
	for(Integer i = 0; i < secretInfoCases.size(); i++){
		Case childCase = new Case();
		childCase.Subject = childCaseSubject;
		childCase.ParentId = secretInfoCases[i].Id;
		childCase.IsEscalated = true;
		childCase.Priority = 'High';
		childCase.Description = 'Parent case associated keyword is : ' + keywords;
		insert childCase;
	}
}