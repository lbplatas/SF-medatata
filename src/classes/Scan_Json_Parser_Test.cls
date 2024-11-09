@IsTest
public class Scan_Json_Parser_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'    \"data\": {'+
		'        \"type\": \"scan\",'+
		'        \"id\": \"1e7dba15_1504_4b1c_8075_4283d56a7d3a\",'+
		'        \"attributes\": {'+
		'            \"url\": \"test\",'+
		'            \"target\": \"SFTest\",'+
		'            \"customer-id\": 14,'+
		'            \"user-id\": 105,'+
		'            \"scan-date\": \"2018_04_10 15:28:25\",'+
		'            \"internal-code\": 2,'+
		'            \"exit-code\": 1,'+
		'            \"status\": \"FAIL\",'+
		'            \"process-time\": \"2018_04_10 15:28:25\",'+
		'            \"number-of-issues\": 10,'+
		'            \"technical-debt\": \"123\",'+
		'            \"quality-of-cloud\": \"70\",'+
		'            \"best-practices-number\": 12,'+
		'            \"scanned-configuration-elements\": 5,'+
		'            \"code-lines\": 1000,'+
		'            \"changes-issues-ratio\": \"70\",'+
		'            \"code-changes-issues-ratio\": \"70\",'+
		'            \"administrators\": \"test\",'+
		'            \"users\": \"test\",'+
		'            \"instance-build-date\": \"0000_00_00 00:00:00\",'+
		'            \"last-upgrade-date\": \"0000_00_00 00:00:00\",'+
		'            \"last-update-set-date\": \"0000_00_00 00:00:00\",'+
		'            \"issues-variation\": 15,'+
		'            \"technical-debt-variation\": 20,'+
		'            \"quality-of-cloud-variation\": 20,'+
		'            \"code-lines-added\": 200,'+
		'            \"engine-version\": 1.0'+
		'        },'+
		'        \"links\": {'+
		'            \"self\": \"http://dev.qualityclouds.com/api/v1/scan/1e7dba15_1504_4b1c_8075_4283d56a7d3a\",'+
		'            \"related\": {'+
		'                \"href\": \"http://dev.qualityclouds.com/api/v1/issue/?filter[scan]=1e7dba15_1504_4b1c_8075_4283d56a7d3a\",'+
		'                \"meta\": {'+
		'                    \"total-warnings\": 0'+
		'                }'+
		'            }'+
		'        }'+
		'    }'+
		'}';
		Scan_Json_Parse r = Scan_Json_Parse.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		Scan_Json_Parse.Meta objMeta = new Scan_Json_Parse.Meta(System.JSON.createParser(json));
		System.assert(objMeta != null);
		System.assert(objMeta.totalWarnings == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		Scan_Json_Parse.Related objRelated = new Scan_Json_Parse.Related(System.JSON.createParser(json));
		System.assert(objRelated != null);
		System.assert(objRelated.href == null);
		System.assert(objRelated.meta == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		Scan_Json_Parse objJSON2Apex = new Scan_Json_Parse(System.JSON.createParser(json));
		System.assert(objJSON2Apex != null);
		System.assert(objJSON2Apex.data == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		Scan_Json_Parse.Attributes objAttributes = new Scan_Json_Parse.Attributes(System.JSON.createParser(json));
		System.assert(objAttributes != null);
		System.assert(objAttributes.url == null);
		System.assert(objAttributes.target == null);
		System.assert(objAttributes.customer_id == null);
		System.assert(objAttributes.user_id == null);
		System.assert(objAttributes.scan_date == null);
		System.assert(objAttributes.internal_code == null);
		System.assert(objAttributes.exit_code == null);
		System.assert(objAttributes.status == null);
		System.assert(objAttributes.process_time == null);
		System.assert(objAttributes.number_of_issues == null);
		System.assert(objAttributes.technical_debt == null);
		System.assert(objAttributes.quality_of_cloud == null);
		System.assert(objAttributes.best_practices_number == null);
		System.assert(objAttributes.scanned_configuration_elements == null);
		System.assert(objAttributes.code_lines == null);
		System.assert(objAttributes.changes_issues_ratio == null);
		System.assert(objAttributes.code_changes_issues_ratio == null);
		System.assert(objAttributes.administrators == null);
		System.assert(objAttributes.users == null);
		System.assert(objAttributes.instance_build_date == null);
		System.assert(objAttributes.last_upgrade_date == null);
		System.assert(objAttributes.last_update_set_date == null);
		System.assert(objAttributes.issues_variation == null);
		System.assert(objAttributes.technical_debt_variation == null);
		System.assert(objAttributes.quality_of_cloud_variation == null);
		System.assert(objAttributes.code_lines_added == null);
		System.assert(objAttributes.engine_version == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		Scan_Json_Parse.Links objLinks = new Scan_Json_Parse.Links(System.JSON.createParser(json));
		System.assert(objLinks != null);
		System.assert(objLinks.self == null);
		System.assert(objLinks.related == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		Scan_Json_Parse.Data objData = new Scan_Json_Parse.Data(System.JSON.createParser(json));
		System.assert(objData != null);
		System.assert(objData.type_Z == null);
		System.assert(objData.id == null);
		System.assert(objData.attributes == null);
		System.assert(objData.links == null);
	}
}