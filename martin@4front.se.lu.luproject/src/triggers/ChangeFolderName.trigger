trigger ChangeFolderName on Account (after insert) {
    Account project = trigger.new[0];

    Account updacc=[select id, FolderId__c from Account where id = :project.id];
    //idan_dm__Folder__c folder = [select Id, idan_dm__Title__c from idan_dm__Folder__c where idan_dm__Title__c = :updacc.FolderId__c];
    
    updacc.FolderId__c = project.FolderId__r.idan_dm__Title__c;
    insert updacc;
}