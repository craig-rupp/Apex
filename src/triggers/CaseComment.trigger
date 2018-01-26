trigger CaseComment on Case (after update) {
    for(Case myCase : Trigger.new){
           CaseComment cc = new CaseComment();
           cc.CommentBody = 'Case received by agent ' + myCase.Owner + '!';
           cc.ParentId = myCase.Id;
           insert cc;
           //always remember to insert/save
    }
}