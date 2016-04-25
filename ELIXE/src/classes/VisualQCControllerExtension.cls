/**
* @author Roman Dovbush (roman@4front.se)
* @version 1.0
* @description Controller for Visual QC page
*
*
* 2016-04-01 : Roman Dovbush - Original
*
**/


public with sharing class VisualQCControllerExtension {

    public String kitID {get; set;}
    public String mode {get; set;}
    public String failureReason {get; set;}
    public String changeReason {get; set;}
    public String box {get; set;}
    public String wellLocation {get; set;}
    public String searchKitId {get; set;}

    public Boolean kitFound {get; set;}
    public Boolean contactFound {get; set;}
    public Boolean initialLoading {get; set;}
    public Boolean selectAll {get; set;}
    public Boolean managerAccess {get; set;}

    public Integer cycleMaximum {get; set;}
    public Integer currentValue {get; set;}

    public List<VisualQCControllerExtension.ScanHistory> scanHistoryList {get; set;}
    public List<OrderItem> failReviewItems {get; set;}

    // Setting initial values in constructor
    public VisualQCControllerExtension() {
        scanHistoryList = new List<VisualQCControllerExtension.ScanHistory>();
        failReviewItems = new List<OrderItem>();
        kitFound = true;
        contactFound = false;
        initialLoading = true;
        selectAll = false;
        managerAccess = false;
        mode = 'pass';
        failureReason = 'Low Volume';  // initial value of Failure Reason pick list on Fail page
        changeReason = 'Low Volume';   // initial value of Failure Reason pick list on Review page
        currentValue = 0;
        cycleMaximum = 0;
        accessManagerView();
        System.debug('Checking contact value: ' + contactFound);
        System.debug('Checking mode value: ' + mode);
    }

    // This method is invoked when you scan Kit.
    public void findKitIdAndContact() {
        kitFound = false;
        contactFound = false;
        initialLoading = false;
        if(kitID != '') {
            // For every scanned sample ScanHistory obj is created to populate
            // Scan History table on the page
            VisualQCControllerExtension.ScanHistory sh = new VisualQCControllerExtension.ScanHistory();
            List<OrderItem> kitList = [Select ID, Kit_ID__c, Kit_Order_Status__c, registeredBy__c, Accessioning_Status__c, Hold_Reason__c, Last_Accessioning_Scan__c, Box__c, Well_Location__c, Failure_Reviewed_By__c from OrderItem Where Kit_ID__c = :kitID];
            if(!kitList.isEmpty()) {
                kitFound = true;
                
                if(kitList[0].registeredBy__c != null) { // do I need here (&& != '')
                    contactFound = true;
                    kitList[0].Accessioning_Status__c = 'Pass';

                    System.debug('Maxval is ' + cycleMaximum);

                    if(currentValue >= cycleMaximum) {
                        currentValue = 1;
                    }
                    else {
                        currentValue++;
                    }
                }
                else {
                    kitList[0].Accessioning_Status__c = 'Hold';
                    kitList[0].Hold_Reason__c = 'Contact Missing';
                }

                if(mode == 'storage') {
                    removeNewLineChar(wellLocation);
                    kitList[0].Box__c = box;
                    kitList[0].Well_Location__c = wellLocation;
                }
                
                if(mode == 'fail') {
                    kitList[0].Accessioning_Status__c = 'FAILURE REVIEW';
                    kitList[0].Failure_Reason__c = failureReason;
                }
                kitList[0].Last_Accessioning_Scan__c = System.now();
                
                System.debug('This is ' + mode);            // for debug reasons;
                System.debug('This is ' + failureReason);   // for debug reasons;
                
                sh.kitId = kitList[0].Kit_ID__c;
                sh.kitStatus = kitList[0].Kit_Order_Status__c;
                sh.accessioningStatus = kitList[0].Accessioning_Status__c;
                sh.holdReason = kitList[0].Hold_Reason__c;
                sh.failureReasonScanned = kitList[0].Failure_Reason__c;
                sh.boxScanned = kitList[0].Box__c; 
                sh.wellLocScanned = kitList[0].Well_Location__c; 
                sh.lastScanDateTime = kitList[0].Last_Accessioning_Scan__c; // do I need to update SF DB with this value?
                sh.currentValScanned = currentValue;
                scanHistoryList.add(sh);
                update kitList;
            }
            kitID = '';
        }
    }

    // This method is invoked when you press Refresh button on the page.
    public void refreshFailReviewItems() {
        failReviewItems = new List<OrderItem>([Select ID, Kit_ID__c, Kit_Order_Status__c, Accessioning_Status__c, 
                            Failure_Reason__c, Failure_Reviewed_By__c, Last_Accessioning_Scan__c, Select_Product__c  
                            from OrderItem Where Accessioning_Status__c = 'FAILURE REVIEW']);
        selectAll = false;
    }

    // This method is invoked when you search for particular Kit ID in database.
    public void getFailReviewItems2() {
        kitFound = false;
        if(searchKitId != '') {
            failReviewItems = new List<OrderItem>([Select ID, Kit_ID__c, Kit_Order_Status__c, Accessioning_Status__c, 
                                Failure_Reason__c, Failure_Reviewed_By__c, Last_Accessioning_Scan__c, Select_Product__c  
                                from OrderItem 
                                Where Kit_ID__c = :searchKitId]);
            if(!failReviewItems.isEmpty()) {
                kitFound = true;
            }
            selectAll = false;
            searchKitId = '';        }
    }

    // This method is invoked when you press Update button on the page.
    // Failure Reason of selected records will be updated in the database.
    public void selectProductToUpdate() {
        for(OrderItem item : failReviewItems) {
            if(item.Select_Product__c) {
                if(changeReason == 'Change to Pass') {
                    item.Accessioning_Status__c = 'PASS';
                    item.Failure_Reason__c = '';
                    item.Select_Product__c = false;
                }
                else {
                    item.Failure_Reason__c = changeReason;
                    item.Select_Product__c = false;
                }
            }
        }
        selectAll = false;
        update failReviewItems;
    }

    // This method is invoked when you press Confirm button on the page.
    // Accessioning Status of selected records will be updated in the database to 'FAIL'.
    public void selectProductToConfirm() {
        for(OrderItem item : failReviewItems) {
            if(item.Select_Product__c) {
                item.Accessioning_Status__c = 'FAIL';
                item.Failure_Reviewed_By__c = UserInfo.getUserId();
                item.Select_Product__c = false;
            }
        }
        selectAll = false;
        update failReviewItems;
    }

    // This method is created to validate Well Location field.
    // When Well is scanned field can be populated with new line char in the end,
    // so we need to remove it before updating DB.
    private String removeNewLineChar(String wellInput) { 
        wellInput = wellInput.remove('\n');
        wellInput = wellInput.remove('\\n');
        wellInput = wellInput.remove(' ');
        wellLocation = wellInput;
        // it is also possible to use wellInput.left(3) function that returns only 3 first letters of given string
        return wellLocation;
    }

    // This method is created to select or deselect All records in Scan table.
    public void selectUnselectAll() {
        if(selectAll) {
            for(OrderItem o : failReviewItems) {
                o.Select_Product__c = false;
            }
            selectAll = false;
        }
        else {
            for(OrderItem o : failReviewItems) {
                o.Select_Product__c = true;
            }
            selectAll = true;
        }
    }

    // This method checks if custom settings exist in SFDC. If yes - method compares
    // profiles with curent user's profile - when they match access to Failure Review page
    // is allowed, if not - disallowed. System Administrator's profile ID is used as default
    // if no custom settings speciifed.
    public void accessManagerView() {
        
        Set_Profile_ID__c pid = Set_Profile_ID__c.getOrgDefaults();
        String setProfileID = pid.Profile_ID__c;
        String currentProfileID = UserInfo.getProfileId();

        System.debug('Custom settings: ' + setProfileID);
        System.debug('Current profile ID: ' + currentProfileID);

        if(setProfileID == '' || setProfileID == null) {
            setProfileID = '00e36000000oZf1AAE';
            managerAccess = true;
        }
        else {
            if(setProfileID.contains(currentProfileID)) {
                managerAccess = true;
            }
            else {
                managerAccess = false;
            }
        }
    }

    // This method clears the Scan History list on the page every time user
    // switches the Accessioning mode.
    public void clearScanList() {
        scanHistoryList.clear();
    }


/* ----------------------------------------------------- */

    // special class for keeping scanned elements
	public class ScanHistory {
		public String kitId {get; set;}
        public Integer currentValScanned {get; set;}
		public String boxScanned {get; set;}
		public String wellLocScanned {get; set;}
		public String kitStatus {get; set;}
		public String failureReasonScanned {get; set;}
		public String holdReason {get; set;}
		public String accessioningStatus {get; set;}
		public Datetime lastScanDateTime {get; set;}
	}

}