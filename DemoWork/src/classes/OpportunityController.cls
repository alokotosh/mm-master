public with sharing class OpportunityController {

    @AuraEnabled
    public static List<Opportunity> getOpportunities() {
        List<Opportunity> opportunities = 
                [SELECT Id, Name, CloseDate FROM Opportunity];
        return opportunities;
    }

    @AuraEnabled
    public static Opportunity getOpportunity(Id id) {
        Opportunity opportunity = [
                SELECT Id, Account.Name, Name, CloseDate, 
                       Owner.Name, Amount, Description, StageName
            FROM Opportunity
            WHERE Id = :id
         ];

        // Perform isAccessible() check here
        // 
       // Map<String,Schema.SObjectField> m = Schema.SObjectType.Opportunity.fields.getMap();
       //    if (!m.get(fieldToCheck).getDescribe().isAccessible()) {

            // Pass error to client
        //    throw new System.NoAccessException();

           // Suppress editor logs
         //  return null;
      //  } 
        return opportunity;
    }
        @AuraEnabled
	public static Opportunity  saveExpense(Opportunity expense) {
    // Perform isUpdateable() check here 
    upsert expense;
    return expense;
}
    @AuraEnabled
public static Opportunity deleteExpense(Opportunity expense) {
    // Perform isDeletable() check here 
    delete expense;
    return expense;
}
    
}