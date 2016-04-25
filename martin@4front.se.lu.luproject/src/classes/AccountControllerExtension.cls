/**
* @author Roman Dovbush (roman@4front.se)
* @version 1.0
* @description Controller extension for Accounts (Projects)
*
*
* 2016-04-8 : Roman Dovbush - Original
*
**/

public with sharing class AccountControllerExtension {

    private final Account projectObj;
    public Account project {get; set;}
    public String status {get; set;}
    public String phase {get; set;}
    public Date tempDate {get; set;}
    public Company__c company {get; set;}
    public List<Project_Markers__c> markersList {get; set;}
    public Set<String> uniqueMarkers {get; set;}

    public Set<String> ideaMarkers = new Set<String>{'Forskaravtal', 'Marknad', 'Person', 'IDF', 'IP Utrett', 'Team', 'Connectr', 'Annan'};
    public Set<String> verificationMarkers = new Set<String>{'Forskaravtal', 'Marknad', 'LOI', 'IP', 'Affärsmodell', 'Finansiering', 'Utkast BP', 'Dedikerad Person', 'Teknik', 'Annan'};
    public Set<String> companyLicenseMarkers = new Set<String>{'Forskaravtal', 'Bolagsstart', 'Styrelse', 'Inom LUIS AB', 'Aktieägaravtal', 'Bolagsordning', 'Budget', 'Affärsplan', 'Finansiering', 'Pressrelease', 'Annan'};



    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public AccountControllerExtension(ApexPages.StandardController stdController) {
        this.projectObj = (Account)stdController.getRecord();
        if(projectObj.Id != null) {
            project = [Select Id, Name, Project_Status__c, Project_Phase__c, Company__c from Account Where Id = :projectObj.Id]; 
        }
        phase = project.Project_Phase__c;
        company = new Company__c();
        uniqueMarkers = new Set<String>();
        //markersList = new List<Project_Markers__c>([Select Id, Marker__c From Project_Markers__c Where Project__c = :project.Id]);
        //for(Project_Markers__c pm : markersList) {
        //    uniqueMarkers.add(pm.Marker__c);
        //}
        // do I need to catch some exceptions here if Id==null?
    }

    //public List<SelectOption> options{get;set;}
    //public List<SelectOption> getItems() {
    //        List<SelectOption> options = new List<SelectOption>();
    //        //options.add(new SelectOption('None','--None--'));
    //        Schema.DescribeFieldResult fieldResult = Account.Project_Phase__c.getDescribe();
    //        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    //        for(Schema.PicklistEntry p : ple)
    //            options.add(new SelectOption(p.getValue(), p.getValue()));       
    //        return options;
    //    }

    public void updatePhase() {
        phase = project.Project_Phase__c;
    }

    public PageReference cancel() {
        return new PageReference('/' + projectObj.Id);
    }

    public PageReference saveStatus() {
        if(phase == 'Commercial') {
            if(project.Company__c == null || project.Company__c == '') {
                Company__c projCompany = new Company__c();
                projCompany.Name = company.Name;
                projCompany.Project__c = project.Id;
                projCompany.Organization_Number__c = company.Organization_Number__c;
                projCompany.Start_Date__c = tempDate;
                insert projCompany;
                Company__c c = [Select Id, Name, Project__c From Company__c Where Project__c = :project.Id];
                project.Company__c = c.Id;
            }
            //createMarker(companyLicenseMarkers);
        }
        if(phase == 'Idea') {
            //createMarker(ideaMarkers);
        }
        if(phase == 'Verification') {
            //createMarker(verificationMarkers);
        }
        if(phase == 'License') {
            //createMarker(companyLicenseMarkers);
        }
        update project;
        return new PageReference('/' + projectObj.Id);
    }


    //public void createMarker(Set<String> tempSet) {
    //    //Boolean markerFound = true;
    //    List<String> storeMarkers = new List<String>();
    //    List<Project_Markers__c> markerToInsert = new List<Project_Markers__c>();
        
    //    if(markersList.isEmpty()) {
    //        storeMarkers.addAll(tempSet);
    //    }
    //    else {
    //        for(String s : tempSet) {
    //            if(!uniqueMarkers.contains(s)) {
    //                storeMarkers.add(s);
    //            }
    //        }
    //    }

    //    for(Integer i=0; i<storeMarkers.size(); i++) {
    //        Project_Markers__c p = new Project_Markers__c(Project__c = project.Id, Marker__c = storeMarkers[i]);
    //        markerToInsert.add(p);
    //    }
    //    insert markerToInsert;
    //    //storeMarkers.clear();
    //}
}