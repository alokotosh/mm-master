trigger CreateMarkers on Account (before insert) {

	Account project = trigger.new[0];
	List<Project_Markers__c> markerToInsert = new List<Project_Markers__c>();
	
	LU_Settings__c customSet = LU_Settings__c.getOrgDefaults();
	String temp = customSet.Project_Markers__c;
	List<String> storeMarkers = temp.split(',');
	
	System.debug('!!!Markers: ' + storeMarkers);
	if(storeMarkers != null) {
		for(Integer i=0; i<storeMarkers.size(); i++) {
	            Project_Markers__c p = new Project_Markers__c(Project__c = project.Id, Marker__c = storeMarkers[i]);
	            markerToInsert.add(p);
	        }
	    insert markerToInsert;
	}
}