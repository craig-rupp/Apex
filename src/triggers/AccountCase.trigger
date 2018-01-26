trigger AccountCase on Account (after insert) {
    for(Account acct : Trigger.new){
        Case cs = new Case();
        cs.OwnerId = '0051N000005v6RT';
        cs.Subject = 'Dedupe this Account';
        cs.AccountId = acct.Id;
        insert cs;
    }
}