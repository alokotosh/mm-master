({
   doInit: function(component, event, helper) {
      //Fetch the expense list from the Apex controller
      helper.getInventoryList(component);
   },
   showDetails: function(component, event, helper) {
        //Get data via "data-data" attribute from button (button itself or icon's parentNode)
        var id = event.target.getAttribute("data-data") || event.target.parentNode.getAttribute("data-data")
        alert(id + " was passed");
   },
   editRecord : function(component, event, helper) {
    // Fire the event to navigate to the edit contact page
    var editRecordEvent = $A.get("e.force:editRecord");
    editRecordEvent.setParams({
        "recordId": component.get("v.inv.Id")
    });
    editRecordEvent.fire();
},
gotoRecord : function(component, event, helper) {
        // Fire the event to navigate to the contact record
        var sObjectEvent = $A.get("e.force:navigateToSObject");
        sObjectEvent.setParams({
            "recordId": component.get("v.inv.Id"),
            "slideDevName": 'related'
        })
        sObjectEvent.fire();
    }
})
