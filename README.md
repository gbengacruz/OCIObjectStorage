# OCIObjectStorage
<p> Step 1. Run the scrpit below on the database </p>
           <p>@install.sql</p>

<p>Sample </p>
<p>--Create Bucket</p>
<p> declare</p>
<p>l_pre_auth varchar2(1200);</p>
<p>begin</p>
    <p>oci_bucket_api.create_bucket(p_credential               =>   , --web credential created for OCI using Apex </p>
	                            <p>p_compartmentid        =>   , --oci compartmentid (ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)</p>
	                            <p>p_namespace            =>   , --oci namespace (idbexxxxxxxxm)</p>
								<p>p_oci_base             =>   , --OCI base (https://objectstorage.us-ashburn-1.oraclecloud.com/n/idbexxxxxxxm/b/)</p>
								<p>p_oci_bucket_base      =>   , --OCI bucket base (https://objectstorage.us-ashburn-1.oraclecloud.com)</p>
								<p>p_oci_bucket_expr      =>   , --oci bucket expiration date for pre auth( 2200-12-31T20:30:00Z)</p>
								<p>p_bucket_name          =>   , --OCI bucket name </p>
								<p>p_pre_auth             => l_pre_auth</p>
								<p>);</p>
								
								
<p>end;</p>					

<p>--upload to oci Bucket</p>
<p>begin</p>
	<p>oci_bucket_api.upload_file(p_credential        =>   ,  --web credential created for OCI using Apex</p>
						  <p>p_oci_bucket_base   =>   ,  --OCI bucket base </p>
						  <p>p_bucket_name       =>   ,  --OCI bucket name </p>
						  <p>p_file_name         =>   ,  --File Name</p>
						  <p>p_mime_type         =>   ,  --mime type</p>
						  <p>p_file              =>      -- File blob</p>
						  <p>);</p>
<p>end;</p>
