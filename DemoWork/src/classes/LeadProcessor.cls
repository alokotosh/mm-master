global class LeadProcessor implements 
    Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
        global String a;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Address, FirstName, LeadSource  ' +
            ' FROM Lead ' + 
            'Where LeadSource = \'Dreamforce \''
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records

        for (Lead lead : scope) {
           lead.FirstName ='Hello';
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            
        }
        update scope;
    }    

    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
       // EmailUtils.sendMessage(a, recordsProcessed);
    }    

}