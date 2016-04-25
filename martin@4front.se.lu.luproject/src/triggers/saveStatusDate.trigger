trigger saveStatusDate on Account (before insert, before update) {

	String startField;
    String endField;
    List<String> statusList = new List<String>{'Active', 'Pending', 'Closed', 'External proceeding', 'Test'};
    Account projectNew = trigger.new[0];
    try {
        Account projectOld = trigger.old[0];

    	for(Integer i=0; i<statusList.size(); i++) {
            if(projectNew.Project_Status__c == statusList[i]) {
                if(projectOld.Project_Status__c != statusList[i]) {
                	if(projectNew.Project_Status__c == 'External proceeding') {
                		startField = 'External_Proceeding_Start__c';
                        endField = String.valueOf(projectOld.Project_Status__c) + '_End_Date__c';
                    }
                    else if(projectOld.Project_Status__c == 'External proceeding') {
                        startField = statusList[i] + '_Start_Date__c';
                		endField = 'External_Proceeding_End__c';
                	}
                	else {
                    	startField = statusList[i] + '_Start_Date__c';
                    	endField = String.valueOf(projectOld.Project_Status__c) + '_End_Date__c';
                    	//System.debug('!!!!!Status ' + startField);
                    }

                    try {
                        projectNew.put(startField, System.today());
                    } 
                    catch(Exception e) {
                        projectNew.addError(startField + ' API does not exist. Please, create it and then try to change Project Status again');
                        System.debug(e.getMessage());
                    }
                    try {
                        projectNew.put(endField, System.today());
                    } 
                    catch(Exception e) {
                        projectNew.addError(endField + ' API does not exist. Please, create it and then try to change Project Status again');
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
        for(Integer i=0; i<statusList.size(); i++) {
            if(projectNew.Project_Status__c == statusList[i]) {
                if(statusList[i] == 'External proceeding') {
                    startField = 'External_Proceeding_Start__c';
                }
                else {
                    startField = statusList[i] + '_Start_Date__c';
                }

                try {
                    projectNew.put(startField, System.today());
                } 
                catch(Exception e) {
                    projectNew.addError(startField + ' API does not exist. Please, create it and then try to change Project Status again');
                    System.debug(e.getMessage());
                }
            }
        }
    }
}