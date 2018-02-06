trigger testLeadDisqualify on Lead (before insert, before update) {
	List<Lead> testLeads = new List<Lead>();
	String testString = 'test';
	for(Lead testLead : Trigger.new){
		if((testLead.FirstName != null && testLead.FirstName.equalsIgnoreCase(testString)) || 
			(testLead.LastName != null && testLead.LastName.equalsIgnoreCase(testString))) {
		   	System.debug('Lead entitled : ' + testLead.FirstName + ' ' + testLead.LastName +  ' ' 
		   		+ testLead.Status + ', will be changed to disqualified');
			testLeads.add(testLead);
		}
	}
	for(Lead removeLeadsDesc : testLeads){
		removeLeadsDesc.Status = 'Disqualified';
	}
}