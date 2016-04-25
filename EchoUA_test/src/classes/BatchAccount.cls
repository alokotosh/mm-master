global class BatchAccount implements Database.Batchable<sObject> {
	
	 Double failedUpdates{get; set;}
	
	
	global Database.QueryLocator start(Database.BatchableContext BC) {

		return Database.getQueryLocator([SELECT id, name, whosf__Count__c FROM Account ]);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
   	 failedUpdates = 0;
   	 Long count=0;
	 List<Account> accs = (List<Account>) scope;
	 List<Contact> con = [SELECT id,accountId, name FROM Contact ];
	 for(Account a: accs)
	 {
	 		for(Contact c: con)
	 		{
	 			if(c.AccountId ==a.id)
	 			{
	 				count++;
	 			}
	 			
	 		}
	 a.whosf__Count__c=count;
	 count=0;

	 }
	         List<Database.SaveResult> dsrs = Database.update(accs, false);
        for(Database.SaveResult dsr : dsrs){
            if(!dsr.isSuccess()){
                failedUpdates++;
            }
	}
}
	
	global void finish(Database.BatchableContext ctx) {

		 AsyncApexJob a = [SELECT id, ApexClassId, 
                       JobItemsProcessed, TotalJobItems, 
                       NumberOfErrors, CreatedBy.Email 
                       FROM AsyncApexJob 
                       WHERE id = :ctx.getJobId()];


        String emailMessage = 'Your batch job '
             + 'AccountOwnerReassignment '
             + 'has finished.  It executed ' 
             + a.totalJobItems 
             + ' batches.  Of which, ' + a.jobitemsprocessed 
             + ' processed without any exceptions thrown and ' 
             + a.numberOfErrors +
             ' batches threw unhandled exceptions.'
             + '  Of the batches that executed without error, ' 
             + failedUpdates 
             + ' records were not updated successfully.';
        
        Messaging.SingleEmailMessage mail = 
              new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.createdBy.email};
        mail.setToAddresses(toAddresses);
        mail.setReplyTo('noreply@salesforce.com');
        mail.setSenderDisplayName('Batch Job Summary');
        mail.setSubject('Batch job completed');
        mail.setPlainTextBody(emailMessage);
        mail.setHtmlBody(emailMessage);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] 
                           { mail });
		
	}
	
} 