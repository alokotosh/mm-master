public with sharing class RandomContactFactory {
	public static List<Employee__c> generateRandomObject(Integer numEmpl, Integer numOppsPerAcct)
	{

		List<Employee__c> emp = new List<Employee__c>();
 
        
        for(Integer i=0;i<numEmpl;i++) {
            Employee__c c = new Employee__c(Name='Employee ' + i,
            						Email__C='example@ex.com',
            						Description__c='Sample Description');
            emp.add(c);
        }
        insert emp;
        
        //List<Employee_Skills__c> es = new List<Employee_Skills__c>();
        //for (Integer j=0;j<numEmpl;j++) {
        //    Employee__c empl = emp[j];
        //    // For each employee just inserted, add skills
        //    for (Integer k=0;k<numOppsPerAcct;k++) {
        //        es.add(new Employee_Skills__c(Employee__c=empl.Name,
        //        							Name='Test skills ' + k,
        //                               Project__c='SolutionSoft',
        //                               Grade__c=3));

        //    }
        //}
        //// Insert all opportunities for all accounts.
        //insert es;

       
		return emp;

	}

}