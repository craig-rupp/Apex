@isTest
private class AppleWatchTest {
	
	@isTest static void createOpp() {
		// Implement test code
		Opportunity opp = new Opportunity();
		opp.Name = '1234';
		opp.StageName = 'Prospecting';
		opp.CloseDate = Date.today();
		insert opp;
	}
	
}