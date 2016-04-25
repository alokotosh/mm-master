trigger SaveCreatedDates on Account (before insert) {

	String startField;
    List<String> statusList = new List<String>{'Active', 'Pending', 'Closed', 'External proceeding'};
	Account projectNew = trigger.new[0];
	
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