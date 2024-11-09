public class Scan_Json_Parse {
    
    public Data data {get;set;} 

	public Scan_Json_Parse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new Data(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'Scan_Json_Parse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Meta {
		public Integer totalWarnings {get;set;} 

		public Meta(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'total-warnings') {
							totalWarnings = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Meta consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Related {
		public String href {get;set;} 
		public Meta meta {get;set;} 

		public Related(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'href') {
							href = parser.getText();
						} else if (text == 'meta') {
							meta = new Meta(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Related consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Attributes {
		public String url {get;set;} 
		public String target {get;set;} 
		public Integer customer_id {get;set;} 
		public Integer user_id {get;set;} 
		public String scan_date {get;set;} 
		public Integer internal_code {get;set;} 
		public Integer exit_code {get;set;} 
		public String status {get;set;} 
		public String process_time {get;set;} 
		public Integer number_of_issues {get;set;} 
		public String technical_debt {get;set;} 
		public String quality_of_cloud {get;set;} 
		public Integer best_practices_number {get;set;} 
		public Integer scanned_configuration_elements {get;set;} 
		public Integer code_lines {get;set;} 
		public String changes_issues_ratio {get;set;} 
		public String code_changes_issues_ratio {get;set;} 
		public String administrators {get;set;} 
		public String users {get;set;} 
		public String instance_build_date {get;set;} 
		public String last_upgrade_date {get;set;} 
		public String last_update_set_date {get;set;} 
		public String issues_variation {get;set;} 
		public String technical_debt_variation {get;set;} 
		public String quality_of_cloud_variation {get;set;} 
		public Integer code_lines_added {get;set;} 
		public String engine_version {get;set;} 

		public Attributes(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'url') {
							url = parser.getText();
						} else if (text == 'target') {
							target = parser.getText();
						} else if (text == 'customer-id') {
							customer_id = parser.getIntegerValue();
						} else if (text == 'user-id') {
							user_id = parser.getIntegerValue();
						} else if (text == 'scan-date') {
							scan_date = parser.getText();
						} else if (text == 'internal-code') {
							internal_code = parser.getIntegerValue();
						} else if (text == 'exit-code') {
							exit_code = parser.getIntegerValue();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'process-time') {
							process_time = parser.getText();
						} else if (text == 'number-of-issues') {
							number_of_issues = parser.getIntegerValue();
						} else if (text == 'technical-debt') {
							technical_debt = parser.getText();
						} else if (text == 'quality-of-cloud') {
							quality_of_cloud = parser.getText();
						} else if (text == 'best-practices-number') {
							best_practices_number = parser.getIntegerValue();
						} else if (text == 'scanned-configuration-elements') {
							scanned_configuration_elements = parser.getIntegerValue();
						} else if (text == 'code-lines') {
							code_lines = parser.getIntegerValue();
						} else if (text == 'changes-issues-ratio') {
							changes_issues_ratio = parser.getText();
						} else if (text == 'code-changes-issues-ratio') {
							code_changes_issues_ratio = parser.getText();
						} else if (text == 'administrators') {
							administrators = parser.getText();
						} else if (text == 'users') {
							users = parser.getText();
						} else if (text == 'instance-build-date') {
							instance_build_date = parser.getText();
						} else if (text == 'last-upgrade-date') {
							last_upgrade_date = parser.getText();
						} else if (text == 'last-update-set-date') {
							last_update_set_date = parser.getText();
						} else if (text == 'issues-variation') {
							issues_variation = parser.getText();
						} else if (text == 'technical-debt-variation') {
							technical_debt_variation = parser.getText();
						} else if (text == 'quality-of-cloud-variation') {
							quality_of_cloud_variation = parser.getText();
						} else if (text == 'code-lines-added') {
							code_lines_added = parser.getIntegerValue();
						} else if (text == 'engine-version') {
							engine_version = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Attributes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Links {
		public String self {get;set;} 
		public Related related {get;set;} 

		public Links(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'self') {
							self = parser.getText();
						} else if (text == 'related') {
							related = new Related(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Links consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Data {
		public String type_Z {get;set;} // in json: type
		public String id {get;set;} 
		public Attributes attributes {get;set;} 
		public Links links {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'type') {
							type_Z = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'attributes') {
							attributes = new Attributes(parser);
						} else if (text == 'links') {
							links = new Links(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static Scan_Json_Parse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new Scan_Json_Parse(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}

}