@isTest
private class oppHW2 {
	
	@isTest static void no_opp_owner() {
		// Implement test code
		User opp_owner = new User();
		opp_owner.FirstName = 'Henrikh';
		opp_owner.LastName = 'Mkhi';
		opp_owner.Email = 'hmkhi@cannons.com';
		opp_owner.Username = 'hmkhi@cannons.com';
		opp_owner.Alias = 'armenian';
		opp_owner.ProfileId = [SELECT Id 
								FROM Profile
								WHERE Name = 'System Administrator'].Id;
		opp_owner.ManagerId = null;
		opp_owner.LanguageLocaleKey = 'en_US';
		opp_owner.EmailEncodingKey = 'UTF-8';
		opp_owner.LocaleSidKey = 'en_US';
		opp_owner.TimeZoneSidKey = 'America/Denver';
		insert opp_owner;

		Opportunity test_opp = new Opportunity();
		test_opp.Name = 'Test Opp';
		test_opp.Amount = 1000;
		test_opp.StageName = 'Prospecting';
		test_opp.CloseDate = Date.today();
		test_opp.OwnerId = opp_owner.Id;
		insert test_opp;

		List<OpportunityTeamMember> otms = [SELECT Id
												FROM OpportunityTeamMember
												WHERE OpportunityId = :test_opp.Id];
		//Assert no Manager Id for recent user owning created opp
		System.assertEquals(0, otms.size());
	}
	
	@isTest static void opp_owner() {
		// Implement test code
		User opp_owner = new User();
		opp_owner.FirstName = 'Henrikh';
		opp_owner.LastName = 'Mkhi';
		opp_owner.Email = 'hmkhi@cannons.com';
		opp_owner.Username = 'hmkhi@cannons.com';
		opp_owner.Alias = 'armenian';
		opp_owner.ProfileId = [SELECT Id 
								FROM Profile
								WHERE Name = 'System Administrator'].Id;
		opp_owner.ManagerId = null;
		opp_owner.LanguageLocaleKey = 'en_US';
		opp_owner.EmailEncodingKey = 'UTF-8';
		opp_owner.LocaleSidKey = 'en_US';
		opp_owner.TimeZoneSidKey = 'America/Denver';
		insert opp_owner;

		User this_me = [SELECT Id 
							FROM User 
							WHERE Id = :UserInfo.getUserId()];
		this_me.ManagerId = opp_owner.Id;
		update this_me;

		Opportunity test_opp = new Opportunity();
		test_opp.Name = 'Test Opp';
		test_opp.Amount = 1000;
		test_opp.CloseDate = Date.today();
		test_opp.StageName = 'Prospecting';
		test_opp.OwnerId = this_me.Id;
		insert test_opp;

		List<OpportunityTeamMember> otms = [SELECT Id
												FROM OpportunityTeamMember
												WHERE OpportunityId = :test_opp.Id
												AND UserId = :opp_owner.Id
												AND TeamMemberRole = 'Sales Manager'];
		//Assert Manager Id for recent user owning created opp
		System.assertEquals(1, otms.size());
	}
	
	@isTest static void opp_sales_rep(){
		//Create Reportee with UserInfo.getUserId() method being attached as User's ManagerId
		User opp_owner = new User();
		opp_owner.FirstName = 'Henrikh';
		opp_owner.LastName = 'Mkhi';
		opp_owner.Email = 'hmkhi@cannons.com';
		opp_owner.Username = 'hmkhi@cannons.com';
		opp_owner.Alias = 'armenian';
		opp_owner.ProfileId = [SELECT Id 
								FROM Profile
								WHERE Name = 'System Administrator'].Id;
		opp_owner.ManagerId = UserInfo.getUserId();
		opp_owner.LanguageLocaleKey = 'en_US';
		opp_owner.EmailEncodingKey = 'UTF-8';
		opp_owner.LocaleSidKey = 'en_US';
		opp_owner.TimeZoneSidKey = 'America/Denver';
		insert opp_owner;

		//Create Opp with yourself as Opp
		Opportunity test_opp = new Opportunity();
		test_opp.Name = 'Test Opp';
		test_opp.StageName = 'Prospecting';
		test_opp.Amount = 1000;
		test_opp.CloseDate = Date.today();
		test_opp.OwnerId = UserInfo.getUserId();
		insert test_opp;

		List<OpportunityTeamMember> otms = [SELECT Id
												FROM OpportunityTeamMember
												WHERE OpportunityId = :test_opp.Id
												AND TeamMemberRole = 'Sales Rep'
												AND UserId = :opp_owner.Id];
		System.assertEquals(1, otms.size());
	}
}