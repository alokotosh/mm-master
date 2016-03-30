public with sharing class CallOut {
	public CallOut() {
		
	}
	 @future(callout=true)
    public static void makeCallout() {
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL.
        String endpoint = 'https://developer.salesforce.com/trailhead/apex_triggers/apex_triggers_intro';
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        HttpResponse response = new HTTP().send(request);
    }
}