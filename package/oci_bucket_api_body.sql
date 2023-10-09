create or replace PACKAGE BODY  oci_bucket_api AS
-- Author       : Gbenga Cruz
-- Description  : OCI Object Storage management
-- Date         : June 20, 2023
 
    -- create oci bucket
    procedure create_bucket(p_credential              in varchar2,
							p_compartmentid       in varchar2,
							p_namespace           in varchar2,
							p_oci_base            in varchar2,
							p_oci_bucket_base     in varchar2,
							p_oci_bucket_expr     in varchar2,
							p_bucket_name         in varchar2,
							p_pre_auth            out varchar2) as
								
    l_clob 	clob;
    begin   
		-- Create a Bucket for client on OCI
		apex_web_service.g_request_headers(1).name := 'Content-Type';
		apex_web_service.g_request_headers(1).value := 'application/json';
		l_clob := apex_web_service.make_rest_request(
		p_url => p_oci_base,
		p_http_method => 'POST',

		p_body => '{
					"compartmentId": "'||p_compartmentid||'",
					"namespace": "'||p_namespace||'",
					"objectEventsEnabled": true,
					"name": "'||p_bucket_name||'",
					"versioning":"Enabled"
				}',
		p_credential_static_id	=> p_credential);

		-- Create a Preauthentication for OCI Bucket 
		apex_web_service.g_request_headers(1).name := 'Content-Type';
		apex_web_service.g_request_headers(1).value := 'application/json';
		l_clob := apex_web_service.make_rest_request(
		p_url =>  p_oci_base||p_bucket_name||'/p/',
		p_http_method => 'POST',

		p_body => '{
					"accessType": "AnyObjectReadWrite",
					"name": "'||p_bucket_name||'AUTH",
					"timeExpires": "'||p_oci_bucket_expr||'"
				}',
		p_credential_static_id	=> p_credential);
		
        -- Get Pre authentication for bucket
		p_pre_auth := p_oci_bucket_base||JSON_VALUE(l_clob, '$.accessUri' );
             
	commit;
	exception when others then
	raise;
	end create_bucket;
	
    -- upload to oci bucket
	procedure upload_file(p_credential        in varchar2,
							p_oci_bucket_base   in varchar2,
							p_bucket_name       in varchar2,
							p_file_name         in varchar2,
							p_mime_type         in varchar2,
							p_file in blob) as

	l_request_url varchar2(32767);
	l_content_length number;

	l_response clob;
	begin

		l_request_url := p_oci_bucket_base||p_bucket_name
		|| '/o/' || apex_util.url_encode(p_file_name);

		apex_web_service.g_request_headers(1).name := 
		'Content-Type';
		apex_web_service.g_request_headers(1).value :=
		p_mime_type;
		l_response := apex_web_service.make_rest_request(
		p_url => l_request_url
		, p_http_method => 'PUT'
		, p_body_blob => p_file
		, p_credential_static_id => p_credential
		);

	end upload_file;
		
end oci_bucket_api;