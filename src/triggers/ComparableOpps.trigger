trigger ComparableOpps on Opportunity (after insert, after update) {


	for(Opportunity oppList : Trigger.new){
		//Query account info for Opp, solely for Account Industry requirement
		Opportunity oppAccountInfo = [SELECT Id, Account.Industry
										FROM Opportunity 
										WHERE Id = :oppList.Id
										LIMIT 1];
		// Search for Comparable Opp ( 1 - Amount within 10%, 2 - Industry Identical, 3 - "Closed Won" in Past year)
		//Bind variables for max / min Opp amount
		Decimal minAmount = oppList.Amount * .9;
		Decimal maxAmount = oppList.Amount * 1.1;

		List<Opportunity> qualifiedOpps = [SELECT Id 
											FROM Opportunity
											WHERE Amount >= :minAmount
											AND Amount <= :maxAmount
											AND Account.Industry = :oppAccountInfo.Account.Industry
											AND StageName = 'Closed Won'
											//See LAST_N_Days usage below - first if closed won in past year, 2nd rep has beein in job over one year
											AND CloseDate >= LAST_N_DAYS:365
											AND Owner.Position_Start_Date__c < LAST_N_DAYS:365
											AND Id != :oppList.Id];
		System.debug('Comparable opp(s) include : ' + qualifiedOpps);
		//For Each Comparable Opp, create a Comparable__c record
		List<Comparable__c> junctionsInsert = new List<Comparable__c>();
		for(Opportunity compOpps : qualifiedOpps){
			Comparable__c junctionObj = new Comparable__c();
			junctionObj.Base_Opportunity__c = oppList.Id;
			junctionObj.Comparable_Opportunity__c = compOpps.Id;
			junctionsInsert.add(junctionObj);
		}
		insert junctionsInsert;
	}
}