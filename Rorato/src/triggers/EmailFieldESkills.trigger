trigger EmailFieldESkills on Employee_Skills__c (before insert) {
    for (Integer i = 0; i < Trigger.new.size(); i++) {

        //Employee_Skills__c.Employee_Email__c = 'example.@ee.com';

        for (Employee_Skills__c e : Trigger.new)
        {
             e.Employee_Email__c ='example.@ee.com';
        }


        

    }

}