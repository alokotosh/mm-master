public with sharing class ExpenseController {

    // ns refers to namespace; leave out ns__ if not needed
    // This method is vulnerable.
    @AuraEnabled
    public static List<Employee_Skills__c> getEmployeeSkills() {
        return [SELECT Id, Name, Employee__c, Employee_Email__c, Status__c,
            Grade__c, CreatedDate FROM Employee_Skills__c];
     }

    // This method is recommended.
    @AuraEnabled
    public static List<Employee_Skills__c> getExpenses() {
        String [] expenseAccessFields = new String [] {'Id',
                                                       'Name',
                                                       'Employee__c',
                                                       'Employee_Email__c',
                                                       'Status__c',
                                                       'Grade__c',
                                                       'CreatedDate'
                                                       };


    // Obtain the field name/token map for the Expense object
    Map<String,Schema.SObjectField> m = Schema.SObjectType.Employee__c.fields.getMap();

    for (String fieldToCheck : expenseAccessFields) {

        // Check if the user has access to view field
        if (!m.get(fieldToCheck).getDescribe().isAccessible()) {

            // Pass error to client
            throw new System.NoAccessException();

           // Suppress editor logs
           return null;
        }
    }

    // Query the object safely
		return [SELECT Id, Name, Employee__c, Employee_Email__c, Status__c,
				Grade__c, CreatedDate FROM Employee_Skills__c];
    }
    

    
}