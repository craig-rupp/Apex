trigger oppHW2 on Opportunity (after insert) {

	for(Opportunity opp : Trigger.new){
		//query opp owner manager info
		Opportunity oppInfoManger = [SELECT Id, Owner.ManagerId
										FROM Opportunity
										WHERE Id = :opp.Id];
		//List of Opp Owners ()
		List<OpportunityTeamMember> otms = new List<OpportunityTeamMember>();
		if(oppInfoManger.Owner.ManagerId != null){
			OpportunityTeamMember otm = new OpportunityTeamMember();
			otm.OpportunityId = opp.Id;
			otm.UserId = oppInfoManger.Owner.ManagerId;
			otm.TeamMemberRole = 'Sales Manager';
			otms.add(otm);
		}
		//Check if Owner is a Manager
		List<User> owner_reportees = [SELECT Id 
										FROM User
										WHERE ManagerId = :opp.OwnerId];

		//Create member for reportee, should user manager match
		if(!owner_reportees.isEmpty()){
			OpportunityTeamMember new_otm = new OpportunityTeamMember();
			new_otm.UserId = owner_reportees.get(0).Id;
			new_otm.OpportunityId = opp.Id;
			new_otm.TeamMemberRole = 'Sales Rep';
			otms.add(new_otm);
		}
		if(!otms.isEmpty()){
			insert otms;
		}	
	}
}