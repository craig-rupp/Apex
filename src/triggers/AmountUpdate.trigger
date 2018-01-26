trigger AmountUpdate on Opportunity (before update) {
    for(Opportunity opp : Trigger.new){
        opp.Amount = 10000;
    }
}