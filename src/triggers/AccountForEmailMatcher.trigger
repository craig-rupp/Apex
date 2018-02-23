trigger AccountForEmailMatcher on Contact (before insert) {
	for(Contact iC : Trigger.new){
		if(iC.Email != null){
			String domain = iC.Email.split('@').get(1);
			String website = 'www.' + domain;
			String httpWeb = 'http://www.' + domain;
			String httpsWeb = 'https://www.' + domain;
			String intDomain = domain + '.%';

			List<Account> matchAccts = [SELECT Id 
											FROM Account
											WHERE Website = :website
											OR Website = :domain
											OR Website = :httpWeb
											OR Website = :httpsWeb
											OR Website LIKE :intDomain];
			if(matchAccts.size() == 1){
				iC.AccountId = matchAccts.get(0).Id;
			}
		}
	}
}