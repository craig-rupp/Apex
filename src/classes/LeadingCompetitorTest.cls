@isTest
private class LeadingCompetitorTest {
	
	@isTest static void createOppsWithCompetitors() {
		// Implement test code
		//Test class for Leading comp Trigger must - 1) Create or Update Opp, 2) Populate 3 Competitor Fields decimal , 3) Populate Competitor(s) picklist selection
		Opportunity newOpp = new Opportunity();
		newOpp.Name = 'Big Deal';
		newOpp.CloseDate = Date.today();
		newOpp.StageName = 'Prospecting';
		//Add Competitor Prices 
		newOpp.Competitor_1_Price__c = 2675;
		newOpp.Competitor_2_Price__c = 2665.25;
		newOpp.Competitor_3_Price__c = 5890.9;
		//Add Competitor Picklist Values
		newOpp.Competitor_1__c = 'Microsoft';
		newOpp.Competitor_2__c = 'Google';
		newOpp.Competitor_3__c = 'Amazon';

		insert newOpp;
		System.debug('New Opportunity : ' + newOpp.Name + ', added with each competitor price/name value');
	}
	
}