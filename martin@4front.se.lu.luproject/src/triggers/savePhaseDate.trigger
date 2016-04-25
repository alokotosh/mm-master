trigger savePhaseDate on Account (before insert, before update) {

    String startField;
    String endField;
    List<String> phaseList = new List<String>{'Contact', 'Idea', 'Verification', 'Development', 'Commercial', 'License', 'Test'};
    Account projectNew = trigger.new[0];

    try {
        Account projectOld = trigger.old[0];

        for(Integer i=0; i<phaseList.size(); i++) {
            if(projectNew.Project_Phase__c == phaseList[i]) {
                if(projectOld.Project_Phase__c != phaseList[i]) {
                    startField = phaseList[i] + '_Start_Date__c';
                    endField = String.valueOf(projectOld.Project_Phase__c) + '_End_Date__c';
                    
                    try {
                        projectNew.put(startField, System.today());
                    } 
                    catch(Exception e) {
                        projectNew.addError(startField + ' API does not exist. Please, create it and then try to change Project Phase again');
                        System.debug(e.getMessage());
                    }
                    try {
                        projectNew.put(endField, System.today());
                    } 
                    catch(Exception e) {
                        projectNew.addError(endField + ' API does not exist. Please, create it and then try to change Project Phase again');
                        System.debug(e.getMessage());
                    }

                    System.debug('!!!Start Date: ' + startField);
                    System.debug('!!!End Date: ' + endField);
                }
            }
        }
    }
    catch (Exception e) {return;}
    finally {
        for(Integer i=0; i<phaseList.size(); i++) {
            if(projectNew.Project_Phase__c == phaseList[i]) {
                    startField = phaseList[i] + '_Start_Date__c';
                try {
                    projectNew.put(startField, System.today());
                } 
                catch(Exception e) {
                    projectNew.addError(startField + ' API does not exist. Please, create it and then try to change Project Phase again');
                    System.debug(e.getMessage());
                }
            }
        }
    }
}