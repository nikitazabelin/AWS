SELECT DISTINCT request_url, COUNT(*) AS count_of_request FROM "default"."$TABLE_NAME"
WHERE elb_status_code >= '404' AND elb_status_code < '405' AND elb LIKE '$ALB_NAME' AND parse_datetime(time,'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z') between parse_datetime('2023-02-26-00:00:00','yyyy-MM-dd-HH:mm:ss') and parse_datetime('2023-03-05-11:00:00','yyyy-MM-dd-HH:mm:ss')
GROUP BY request_url 
ORDER BY 2 DESC;

SELECT * FROM "default"."$TABLE_NAME"
WHERE elb_status_code >= '400' AND elb_status_code < '500' AND elb LIKE '$ALB_NAME' AND parse_datetime(time,'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z') between parse_datetime('2023-02-04-00:30:00','yyyy-MM-dd-HH:mm:ss') and parse_datetime('2023-02-04-02:00:00','yyyy-MM-dd-HH:mm:ss')
ORDER BY time DESC

ELECT * FROM "default"."$TABLE_NAME"
WHERE elb_status_code >= '400' AND elb_status_code < '500' AND elb LIKE '$ALB_NAME' AND parse_datetime(time,'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z') between parse_datetime('2023-02-04-00:30:00','yyyy-MM-dd-HH:mm:ss') and parse_datetime('2023-02-04-02:00:00','yyyy-MM-dd-HH:mm:ss')
ORDER BY time DESC

CREATE EXTERNAL TABLE IF NOT EXISTS alb_logs( type string, time string, elb string, client_ip string, client_port int, target_ip string, target_port int, request_processing_time double, target_processing_time double, response_processing_time double, elb_status_code string, target_status_code string, received_bytes bigint, sent_bytes bigint, request_verb string, request_url string, request_proto string, user_agent string, ssl_cipher string, ssl_protocol string, target_group_arn string, trace_id string, domain_name string, chosen_cert_arn string, matched_rule_priority string, request_creation_time string, actions_executed string, redirect_url string, lambda_error_reason string, target_port_list string, target_status_code_list string, new_field string ) ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe' WITH SERDEPROPERTIES ( 'serialization.format' = '1', 'input.regex' = '([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \"([^ ]*) ([^ ]*) (- |[^ ]*)\" \"([^\"]*)\" ([A-Z0-9-]+) ([A-Za-z0-9.-]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" ([-.0-9]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^ ]*)\" \"([^\s]+)\" \"([^\s]+)\"(.*)') LOCATION '$s3://PATH'