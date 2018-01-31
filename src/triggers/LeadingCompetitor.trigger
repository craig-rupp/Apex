trigger LeadingCompetitor on Opportunity (before insert, before update) {

	//List<Decimal> compPrices = new List<Decimal>();
	for (Opportunity opp : Trigger.new){
		//push each competitor price decimal field into array/list
		List<Decimal> compPrices = new List<Decimal>();
		compPrices.add(opp.Competitor_1_Price__c);
		compPrices.add(opp.Competitor_2_Price__c);
		compPrices.add(opp.Competitor_3_Price__c);

		//add list of strings for each Competitor
		List<String> compName = new List<String>();
		compName.add(opp.Competitor_1__c);
		compName.add(opp.Competitor_2__c);
		compName.add(opp.Competitor_3__c);

		//loop through all competitors to find the position of the lowest price
		Decimal lowestPrice;
		Integer lowestPricePosition;
		Decimal highestPrice;
		Integer highestPricePosition;
		for (Integer i = 0; i < compPrices.size(); i++){
			Decimal currentPrice = compPrices.get(i);
			if(lowestPrice == null || currentPrice < lowestPrice){
				lowestPrice = currentPrice;
				lowestPricePosition = i;
			}
			if(highestPrice == null || currentPrice > highestPrice){
				highestPrice = currentPrice;
				highestPricePosition = i;
			}

		}
		//populate leading competitor field with the competitor matching the lowest price position
		opp.Leading_Competitor__c = compName.get(lowestPricePosition);
		opp.Most_Expensivest__c = compName.get(highestPricePosition);
		opp.Most_Expensivest_Price__c = compPrices.get(highestPricePosition);
	}

}