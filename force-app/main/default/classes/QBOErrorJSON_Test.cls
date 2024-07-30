@IsTest
public class QBOErrorJSON_Test {
	
	static testMethod void testParse() {
		String json = '{\"Fault\":{\"Error\":[{\"Message\":\"A business validation error has occurred while processing your request\",\"Detail\":\"Business Validation Error: Were sorry, QuickBooks encountered an error while calculating tax. Try reselecting the tax rate or reentering the product/service item and saving the form again.\",\"code\":\"6000\",\"element\":\"\"}],\"type\":\"ValidationFault\"},\"time\":\"2019-11-06T21:40:41.673-08:00\"}';
		QBErrorJSON r = QBErrorJSON.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBErrorJSON objQBOErrorJSON = new QBErrorJSON(System.JSON.createParser(json));
		System.assert(objQBOErrorJSON != null);
		System.assert(objQBOErrorJSON.Fault == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBErrorJSON.Error objError = new QBErrorJSON.Error(System.JSON.createParser(json));
		System.assert(objError != null);
		System.assert(objError.Message == null);
		System.assert(objError.Detail == null);
		System.assert(objError.code == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBErrorJSON.Fault objFault = new QBErrorJSON.Fault(System.JSON.createParser(json));
		System.assert(objFault != null);
		System.assert(objFault.Error == null);
	}
}