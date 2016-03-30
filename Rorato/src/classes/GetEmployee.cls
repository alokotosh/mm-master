public class GetEmployee {
    
     public static Employee_Skills__c OneEmployee ()
    {
        List<Employee_Skills__c> em = [Select id, Name, CreatedById from Employee_Skills__c ];
        Employee_Skills__c e = em.get(0);
        return e;
    }
   

}