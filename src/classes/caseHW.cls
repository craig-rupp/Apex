@isTest
private class caseHW {
	
	@isTest static void lessThanTwo() {
		// New Contact - match to new Case, Assert Status is still New
		Contact newC = new Contact();
		newC.LastName = 'Mkhi';
		insert newC;

		Case newCase = new Case ();
		newCase.Status = 'New';
		newCase.ContactId = newC.Id;
		insert newCase;

		Case testCase = [SELECT Id, Status 
							FROM Case
								WHERE Id = :newCase.Id
								LIMIT 1];
		//Assert testCase status is New - not 'closed'
		System.assertEquals('New', testCase.Status);

	}
	
	@isTest static void TwoOrMore() {
		// Contact, link Cases, Assert Status is Closed
		Contact cont = new Contact();
		cont.LastName = 'Mkhi';
		insert cont;

		List<Case> casesList= new List<Case>();
		for(integer i = 0; i < 2; i++){
			Case cs = new Case();
			cs.ContactId = cont.Id;
			casesList.add(cs);
		}
		insert casesList;

		Case another = new Case();
		another.ContactId = cont.Id;
		insert another;

		//have to query after inserting
		Case anotherQuery = [SELECT Id, Status 
								FROM Case
									WHERE Id = :another.Id];

		System.assertEquals('Closed', anotherQuery.Status);

	}

	@isTest static void AccountThree(){
		Account acct = new Account();
		acct.Name = 'Deduping';
		insert acct;

		List<Case> accountCases = new List<Case>();
		for(integer i = 0; i < 3; i++){
			Case testCs = new Case();
			testCs.AccountId = acct.Id;
			accountCases.add(testCs);
		}
		insert accountCases;

		Case checkCase = new Case();
		checkCase.AccountId = acct.Id;
		insert checkCase;

		//query case to check status for System Assert
		Case accountQuery = [SELECT Id, Status 
								FROM Case
									WHERE Id = :checkCase.Id];
		System.assertEquals('Closed', accountQuery.Status);
	}
	
}