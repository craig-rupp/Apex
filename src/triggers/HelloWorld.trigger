trigger HelloWorld on Lead (before update) {
    for(Lead acct : Trigger.new){
        acct.FirstName = 'Hello';
        acct.LastName = 'World';
    }
}