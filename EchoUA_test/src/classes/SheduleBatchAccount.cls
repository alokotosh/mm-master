global class SheduleBatchAccount implements Schedulable {
	global void execute(SchedulableContext sc) {
		whosf.BatchAccount b = new whosf.BatchAccount();
		database.executebatch(b);
	}
}