@isTest
private class ComparableOpps {
	
	@isTest static void noComparableOpps() {
		//Create Records
		Account acc = new Account();
		acc.Name = 'Grand Budapest';
		acc.Industry = 'Hospitality';
		insert acc;

		Opportunity opp = new Opportunity();
		opp.Name = 'Grand Budapest';
		opp.AccountId = acc.Id;
		opp.Amount = 2500;
		opp.StageName = 'Prospecting';
		opp.CloseDate = Date.today();
		insert opp;

		//Query Latest Values 
		List<Comparable__c> comparables = [SELECT Id
										FROM Comparable__c
											WHERE Base_Opportunity__c = :opp.Id];
		
		//System Assert 
		System.assertEquals(0, comparables.size());
	}
	
	@isTest static void multipleComparableOpps() {
		//Create records - we need two comparable opps
		Account acc = new Account();
		acc.Name = 'Grand Budapest';
		acc.Industry = 'Hospitality';
		insert acc;

		List<Opportunity> compOpps = new List<Opportunity>();
		Opportunity comp1 = new Opportunity();
		comp1.Name = 'Grand Budapest';
		comp1.AccountId = acc.Id;
		comp1.Amount = 2470;
		comp1.StageName = 'Closed Won';
		comp1.CloseDate = Date.today().addDays(-1);
		compOpps.add(comp1);

		Opportunity comp2 = new Opportunity();
		comp2.Name = 'Grand Budapest';
		comp2.AccountId = acc.Id;
		comp2.Amount = 2515;
		comp2.StageName = 'Closed Won';
		comp2.CloseDate = Date.today().addDays(-100);
		compOpps.add(comp2);
		insert compOpps;

		Opportunity baseOpp = new Opportunity();
		baseOpp.Name = 'Grand Budapest';
		baseOpp.AccountId = acc.Id;
		baseOpp.Amount = 2500;
		baseOpp.StageName = 'Prospecting';
		baseOpp.CloseDate = Date.today();
		insert baseOpp;

		List<Comparable__c> matchingComparables = [SELECT Id, Comparable_Opportunity__c
													FROM Comparable__c
														WHERE Base_Opportunity__c = :baseOpp.Id
															ORDER BY Comparable_Opportunity__r.CloseDate DESC];
		//Assert Equals
		//System.debug(matchingComparables);
		System.assertEquals(comp1.Id, matchingComparables.get(0).Comparable_Opportunity__c);
		System.assertEquals(comp2.Id, matchingComparables.get(1).Comparable_Opportunity__c);

	}
	
}