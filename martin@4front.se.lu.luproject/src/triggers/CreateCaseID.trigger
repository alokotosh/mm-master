trigger CreateCaseID on Account (before insert) {

    Integer currentYear = System.today().year();
    String projName = '';
    String folderId = '';
    String caseId = '';

    Map<Id, University__c> universitiesMap = new Map<Id, University__c>([SELECT Id, Name, 
                                                Short_Name__c, Project_Count__c, Folder_Id__c FROM University__c]);

    for(Account project : Trigger.new) {

        if(universitiesMap.containsKey(project.University__c)) {
            universitiesMap.get(project.University__c).Project_Count__c++;
            caseId = (universitiesMap.get(project.University__c).Short_Name__c + '-' + currentYear
            + '-' + universitiesMap.get(project.University__c).Project_Count__c);
            projName = project.Name;
            folderId = universitiesMap.get(project.University__c).Folder_Id__c;
            project.Case_Id__c = caseId;

            idan_dm__Folder__c ff = new idan_dm__Folder__c();
            ff.idan_dm__Title__c = projName;
            ff.idan_dm__ParentFolderId__c = folderId;
            insert ff;

        }
    }

    if (!universitiesMap.isEmpty()) {
        update universitiesMap.values();
    }

    
}