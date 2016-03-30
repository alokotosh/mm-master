({
    doInit : function(component, event) {
        var action = component.get("c.findAll");
        action.setCallback(this, function(a) {
            component.set("v.inventories", a.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    editRecord : function(component, event, helper) {
        // Fire the event to navigate to the edit inventory page
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.inventory.Id")
        });
        editRecordEvent.fire();
    },
    searchKeyChange: function(component, event) {
    var searchKey = event.getParam("searchKey");
    var action = component.get("c.findByString");
    action.setParams({
      "searchKey": searchKey
    });
    action.setCallback(this, function(a) {
        component.set("v.inventories", a.getReturnValue());
    });
    $A.enqueueAction(action);
}
})