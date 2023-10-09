create or replace PACKAGE  oci_bucket_api AS
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
								p_pre_auth            out varchar2);
	
	-- upload to oci bucket
	procedure upload_file(p_credential        in varchar2,
						  p_oci_bucket_base   in varchar2,
						  p_bucket_name       in varchar2,
						  p_file_name         in varchar2,
						  p_mime_type         in varchar2,
						  p_file in blob);
	
end oci_bucket_api;